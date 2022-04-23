// 
// 

import Foundation

/// The ready event is dispatched when a client has completed the initial handshake with the gateway (for new sessions).
/// The ready event can be the largest and most complex event the gateway will send, as it contains all the state required for a client to begin interacting with the rest of the platform.
/// - seealso: https://discord.com/developers/docs/topics/gateway#ready-ready-event-fields
struct GatewayReady: Codable {
  /// Gateway version
  let version: GatewayVersion
  /// Information about the user including email
  let user: User
  /// The guilds the user is in
  let guilds: [UnavailableGuild]
  /// Used for resuming connections
  let sessionID: String
  /// The shard information associated with this session, if sent when identifying
  let shard: GatewayShard?
  /// Contains id and flags
  let application: PartialApplication
}

extension GatewayReady {
  enum CodingKeys: String, CodingKey {
    case version = "v"
    case user
    case guilds
    case sessionID = "session_id"
    case shard
    case application
  }
}
