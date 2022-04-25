// 
// 

import Foundation

/// Used to trigger the initial handshake with the gateway.
/// - seealso: https://discord.com/developers/docs/topics/gateway#identify
struct GatewayIdentify: Codable {
  /// Authentication token
  let token: String
  /// Connection properties
  let properties: GatewayConnectionProperties
  /// Whether this connection supports compression of packets
  let compress: Bool?
  /// Value between 50 and 250, total number of members where the gateway will stop sending offline members in the guild member list
  let largeThreshold: Int?
  /// Used for Guild Sharding
  let shard: GatewayShard?
  /// Presence structure for initial presence information
  let presence: GatewayPresenceUpdate?
  /// The Gateway Intents you wish to receive
  let intents: GatewayIntents
}

extension GatewayIdentify {
  enum CodingKeys: String, CodingKey {
    case token
    case properties
    case compress
    case largeThreshold = "large_threshold"
    case shard
    case presence
    case intents
  }
}
