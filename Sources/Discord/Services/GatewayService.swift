// 
// 

import Foundation

public protocol GatewayService {
  var isConnected: CurrentValueSubject<Bool> { get }
  var isReady: CurrentValueSubject<Bool> { get }
  
  var didReceiveEvent: PassthroughSubject<GatewayEvent> { get }
  
  func connect(intents: GatewayIntents)
}

final class GatewayServiceImpl: NSObject {
  private let environmentService: EnvironmentService
  private let networkingService: NetworkingService
  private let authService: AuthenticationService
  
  private lazy var jsonDecoder: JSONDecoder = .iso8601
  private lazy var jsonEncoder: JSONEncoder = .iso8601
  
  private var connectTask: Task<Void, Error>?
  private var heartbeatTask: Task<Void, Error>?
  private var socketTask: URLSessionWebSocketTask?
  
  @Published private var helloData: GatewayHello?
  @Published private var readyData: GatewayReady?
  private var lastPayload: GatewayPayload?
  
  private var intents: GatewayIntents = []
  
  let isConnected: CurrentValueSubject<Bool> = .init(false)
  let isReady: CurrentValueSubject<Bool> = .init(false)
  
  let didReceiveEvent: PassthroughSubject<GatewayEvent> = .init()
  
  init(environmentService: EnvironmentService,
       authService: AuthenticationService,
       networkingService: NetworkingService) {
    self.environmentService = environmentService
    self.authService = authService
    self.networkingService = networkingService
  }
}

// MARK: GatewayService
extension GatewayServiceImpl: GatewayService {
  func connect(intents: GatewayIntents) {
    cleanUp()
    self.intents = intents
    connectTask = Task {
      let auth = try authService.authentication.unwrapped()
      let gateway: URL
      switch auth {
      case .token:    gateway = try await getGateway().url
      case .botToken: gateway = try await getGatewayBot().url
      }
      let gatewayURL = try gatewayURL(url: gateway)
      socketTask = URLSession.shared.webSocketTask(with: gatewayURL)
      socketTask?.delegate = self
      socketTask?.resume()
      try await readMessage()
    }
  }
}

// MARK: Message
private extension GatewayServiceImpl {
  func readMessage() async throws {
    let socketTask = try socketTask.unwrapped()
    let message = try await socketTask.receive()
    let messageData: Data
    switch message {
    case let .data(data):     messageData = data
    case let .string(string): messageData = Data(string.utf8)
    @unknown default: fatalError()
    }
    handleMessage(data: messageData)
    try await readMessage()
  }
  
  private func handleMessage(data: Data) {
    do {
      let payload = try jsonDecoder.decode(GatewayPayload.self, from: data)
      var event: GatewayEvent?
      switch payload.eventData {
      case let .hello(hello):
        helloData = hello
        resetHeartbeat()
        identify()
      case .heartbeat:
        // The gateway may request a heartbeat from the client in some situations by sending an Opcode 1 Heartbeat.
        // When this occurs, the client should immediately send an Opcode 1 Heartbeat without waiting the remainder of the current interval.
        resetHeartbeat(wait: false)
      case let .ready(ready):
        readyData = ready
      case let .messageCreate(message):
        event = .messageCreate(message)
      case .identify:
        break
      case .none:
        break
      }
      lastPayload = payload
      if let event = event {
        didReceiveEvent.send(event)
      }
      print(payload)
    } catch {
      print(error)
    }
  }
  
  func sendMessage(payload: GatewayPayload) async throws {
    let data = try jsonEncoder.encode(payload)
    try await socketTask?.send(.data(data))
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
    connectTask?.cancel()
    connectTask = nil
    socketTask?.cancel()
    socketTask = nil
    heartbeatTask?.cancel()
    heartbeatTask = nil
    // Data
    intents = []
    helloData = nil
    readyData = nil
    lastPayload = nil
  }
}

// MARK: URLSessionTaskDelegate
extension GatewayServiceImpl: URLSessionWebSocketDelegate {
  func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {

  }
  
  func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
    cleanUp()
  }
}
