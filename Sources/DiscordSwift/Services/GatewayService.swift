// 
// 

import Foundation

public protocol GatewayService {
  var didReceiveEvent: AnyPublisher<GatewayEvent, Never> { get }
  var didClose: AnyPublisher<Void, Never> { get }
  
  func connect(intents: GatewayIntents) async throws
}

final class GatewayServiceImpl: NSObject {
  private let environmentService: EnvironmentService
  private let networkingService: NetworkingService
  private let authService: AuthenticationService
  private let webSocketService: WebSocketService
  
  private lazy var jsonDecoder: JSONDecoder = .iso8601
  private lazy var jsonEncoder: JSONEncoder = .iso8601
  
  private var heartbeatTask: Task<Void, Error>?
  
  private var helloData: GatewayHello?
  private var readyData: GatewayReady?
  private var lastPayload: GatewayPayload?
  
  private var intents: GatewayIntents = []
  
  private let didReceiveEventSubject: PassthroughSubject<GatewayEvent, Never> = .init()
  private let didCloseSubject: PassthroughSubject<Void, Never> = .init()

  init(environmentService: EnvironmentService,
       authService: AuthenticationService,
       networkingService: NetworkingService,
       webSocketService: WebSocketService) {
    self.environmentService = environmentService
    self.authService = authService
    self.networkingService = networkingService
    self.webSocketService = webSocketService
  }
}

// MARK: GatewayService
extension GatewayServiceImpl: GatewayService {
  var didReceiveEvent: AnyPublisher<GatewayEvent, Never> { didReceiveEventSubject.eraseToAnyPublisher() }
  var didClose: AnyPublisher<Void, Never> { didCloseSubject.eraseToAnyPublisher() }
  
  func connect(intents: GatewayIntents) async throws {
    try await connect(intents: intents, shouldCleanUp: true)
  }
  
  private func connect(intents: GatewayIntents, shouldCleanUp: Bool) async throws {
    if shouldCleanUp {
      cleanUp()
    }
    self.intents = intents
    let auth = try authService.authentication.unwrapped()
    let gateway: URL
    switch auth {
    case .token:    gateway = try await getGateway().url
    case .botToken: gateway = try await getGatewayBot().url
    }
    let gatewayURL = try gatewayURL(url: gateway)
    weak var weakSelf = self
    try await webSocketService.connect(url: gatewayURL,
                                       handle: { weakSelf?.handleMessage(data: $0) },
                                       onClose: { weakSelf?.handleClose(code: $0) })
  }
  
  func reconnect() {
    Task {
      try await Task.sleep(nanoseconds: 1_000_000_000 * .random(in: 1...5))
      try await connect(intents: intents, shouldCleanUp: false)
    }
  }
}

// MARK: Close
private extension GatewayServiceImpl {
  func close() {
    Task {
      try await webSocketService.close()
    }
  }
  
  func handleClose(code: Int) {
    let closeEvent = GatewayCloseEventCode(rawValue: code)
    let shouldReconnect = closeEvent?.shouldReconnect ?? false
    guard !shouldReconnect else {
      return reconnect()
    }
    // Close
    didCloseSubject.send()
  }
}

// MARK: Message
private extension GatewayServiceImpl {
  func handleMessage(data: Data) {
    do {
      try print("------------------------\n\(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)) " + String(data: data, encoding: .utf8).unwrapped())
      let payload = try jsonDecoder.decode(GatewayPayload.self, from: data)
      var event: GatewayEvent?
      switch payload.eventData {
      case let .hello(hello):
        helloData = hello
        resetHeartbeat()
        if let readyData = readyData {
          resume(readyData: readyData)
        } else {
          identify()
        }
      case .heartbeat:
        // The gateway may request a heartbeat from the client in some situations by sending an Opcode 1 Heartbeat.
        // When this occurs, the client should immediately send an Opcode 1 Heartbeat without waiting the remainder of the current interval.
        resetHeartbeat(wait: false)
      case let .ready(ready):
        readyData = ready
      case .reconnect:
        reconnect()
      case let .invalidSession(resumable: resumable):
        if resumable {
          reconnect()
        } else {
          close()
        }
      case .identify:
        break
      case .resume:
        break
      case .resumed:
        // Resume succeed
        break
      // Events
      case let .messageCreate(message):
        event = .messageCreate(message)
      case let .messageUpdate(message):
        event = .messageUpdate(message)
      case let .messageDelete(messageDelete):
        event = .messageDelete(messageDelete)
      case let .interactionCreate(interaction):
        event = .interactionCreate(interaction)
      case .none:
        break
      }
      if payload.sequenceNumber != nil {
        lastPayload = payload
      }
      if let event = event {
        didReceiveEventSubject.send(event)
      }
      print("------------------------\nRECEIVE: \(payload)")
    } catch {
      print(error)
    }
  }
  
  func sendMessage(payload: GatewayPayload) async throws {
    print("------------------------\nSEND: \(payload)")
    let data = try jsonEncoder.encode(payload)
    try await webSocketService.send(data: data)
  }
}

// MARK: Heartbeat
private extension GatewayServiceImpl {
  func resetHeartbeat(wait: Bool = true) {
    heartbeatTask?.cancel()
    heartbeatTask = Task {
      try await heartbeat(wait: wait, jitter: true)
    }
  }
  
  func heartbeat(wait: Bool, jitter: Bool) async throws {
    guard let heartbeatInterval = helloData?.heartbeatInterval else { return }
    if wait {
      let delay = UInt64(1_000_000_000 * heartbeatInterval.seconds)
      try await Task.sleep(nanoseconds: jitter ? .random(in: 0...delay) : delay)
    }
    try await sendHeartbeatMessage()
    try await heartbeat(wait: true, jitter: false)
  }
  
  private func sendHeartbeatMessage() async throws {
    try await sendMessage(payload: .init(op: .heartbeat,
                                         eventData: .heartbeat(sequenceNumber: lastPayload?.sequenceNumber),
                                         sequenceNumber: nil,
                                         eventName: nil))
  }
}

// MARK: Identify
private extension GatewayServiceImpl {
  func identify() {
    Task {
      try await sendIdentifyMessage()
    }
  }
  
  private func sendIdentifyMessage() async throws {
    let token = try authService.authentication.unwrapped()
    try await sendMessage(payload: .init(op: .identify,
                                         eventData: .identify(.init(token: token.stringValue,
                                                                    properties: .init(os: ProcessInfo.processInfo.osName,
                                                                                      browser: environmentService.libraryName,
                                                                                      device: environmentService.libraryName),
                                                                    compress: nil,
                                                                    largeThreshold: nil,
                                                                    shard: nil,
                                                                    presence: nil,
                                                                    intents: intents)),
                                         sequenceNumber: nil,
                                         eventName: nil))
  }
}

// MARK: Resume
private extension GatewayServiceImpl {
  func resume(readyData: GatewayReady) {
    Task {
      try await sendResumeMessage(readyData: readyData)
    }
  }
  
  private func sendResumeMessage(readyData: GatewayReady) async throws {
    let token = try authService.authentication.unwrapped().stringValue
    let sessionID = readyData.sessionID
    try await sendMessage(payload: .init(op: .resume,
                                         eventData: .resume(.init(token: token,
                                                                  sessionID: sessionID,
                                                                  sequenceNumber: lastPayload?.sequenceNumber)),
                                         sequenceNumber: nil,
                                         eventName: nil))
  }
}

extension GatewayServiceImpl {
  /// - seealso: https://discord.com/developers/docs/topics/gateway#connecting-gateway-url-query-string-params
  func gatewayURL(url: URL) throws -> URL {
    var url = try URLComponents(url: url, resolvingAgainstBaseURL: false).unwrapped()
    url.queryItems = [
      URLQueryItem(name: "v", value: String(environmentService.gatewayVersion.rawValue)),
      URLQueryItem(name: "encoding", value: "json")
    ] + (url.queryItems ?? [])
    return try url.url.unwrapped()
  }
  
  /// Returns an object with a single valid WSS URL, which the client can use for Connecting.
  /// Clients should cache this value and only call this endpoint to retrieve a new URL if they are unable to properly establish a connection using the cached version of the URL.
  /// - seealso: https://discord.com/developers/docs/topics/gateway#get-gateway
  func getGateway() async throws -> Gateway {
    try await networkingService.request(method: .get, path: "/gateway")
  }
  
  /// Returns an object based on the information in Get Gateway, plus additional metadata that can help during the operation of large or sharded bots.
  /// Unlike the Get Gateway, this route should not be cached for extended periods of time as the value is not guaranteed to be the same per-call,
  /// and changes as the bot joins/leaves guilds.
  /// - seealso: https://discord.com/developers/docs/topics/gateway#get-gateway-bot
  func getGatewayBot() async throws -> GatewayBot {
    try await networkingService.request(method: .get, path: "/gateway/bot")
  }
}

extension GatewayServiceImpl {
  /// Cancel all tasks and cleanup data
  func cleanUp() {
    // Tasks
    heartbeatTask?.cancel()
    heartbeatTask = nil
    // Data
    intents = []
    helloData = nil
    readyData = nil
    lastPayload = nil
  }
}
