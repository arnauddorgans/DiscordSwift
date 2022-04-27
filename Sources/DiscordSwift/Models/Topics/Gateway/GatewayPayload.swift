// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/gateway#payloads-gateway-payload-structure
struct GatewayPayload {
  /// Opcode for the payload
  let op: GatewayOpcode
  /// Event data
  let eventData: GatewayData
  /// Sequence number, used for resuming sessions and heartbeats
  let sequenceNumber: Int?
  /// The event name for this payload
  let eventName: GatewayEventName?
}

// MARK: Decodable
extension GatewayPayload: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    op = try container.decode(GatewayOpcode.self, forKey: .op)
    sequenceNumber = try container.decodeIfPresent(Int.self, forKey: .sequenceNumber)
    eventName = try container.decodeIfPresent(GatewayEventName.self, forKey: .eventName)
    switch op {
    case .hello:
      let hello = try container.decode(GatewayHello.self, forKey: .eventData)
      eventData = .hello(hello)
    case .heartbeat:
      let sequenceNumber = try container.decode(Int.self, forKey: .eventData)
      eventData = .heartbeat(sequenceNumber: sequenceNumber)
    case .identify:
      let identify = try container.decode(GatewayIdentify.self, forKey: .eventData)
      eventData = .identify(identify)
    case .resume:
      let resume = try container.decode(GatewayResume.self, forKey: .eventData)
      eventData = .resume(resume)
    case .invalidSession:
      let resumable = try container.decode(Bool.self, forKey: .eventData)
      eventData = .invalidSession(resumable: resumable)
    case .dispatch:
      switch eventName {
      case .ready:
        let ready = try container.decode(GatewayReady.self, forKey: .eventData)
        eventData = .ready(ready)
      case .messageCreate:
        let message = try container.decode(Message.self, forKey: .eventData)
        eventData = .messageCreate(message)
      case .messageDelete:
        let messageDelete = try container.decode(GatewayMessageDelete.self, forKey: .eventData)
        eventData = .messageDelete(messageDelete)
      case .resumed:
        eventData = .resumed
      default:
        eventData = .none
      }
    default:
      eventData = .none
    }
  }
}

// MARK: Encodable
extension GatewayPayload: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(op, forKey: .op)
    try container.encode(sequenceNumber, forKey: .sequenceNumber)
    try container.encode(eventName, forKey: .eventName)
    switch eventData {
    case .none:
      try container.encodeNil(forKey: .eventData)
    case let .hello(hello):
      try container.encode(hello, forKey: .eventData)
    case let .heartbeat(sequenceNumber: sequenceNumber):
      try container.encode(sequenceNumber, forKey: .eventData)
    case let .identify(identify):
      try container.encode(identify, forKey: .eventData)
    case let .resume(resume):
      try container.encode(resume, forKey: .eventData)
    case let .ready(ready):
      try container.encode(ready, forKey: .eventData)
    case let .messageCreate(message):
      try container.encode(message, forKey: .eventData)
    case let .messageUpdate(message):
      try container.encode(message, forKey: .eventData)
    case let .messageDelete(messageDelete):
      try container.encode(messageDelete, forKey: .eventData)
    case let .invalidSession(resumable: resumable):
      try container.encode(resumable, forKey: .eventData)
    case .resumed:
      break
    }
  }
}

extension GatewayPayload {
  enum CodingKeys: String, CodingKey {
    case op
    case eventData = "d"
    case sequenceNumber = "s"
    case eventName = "t"
  }
}
