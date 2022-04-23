// 
// 

import Foundation

/// Sent on connection to the websocket. Defines the heartbeat interval that the client should heartbeat to.
/// - seealso: https://discord.com/developers/docs/topics/gateway#hello
struct GatewayHello: Codable {
  /// The interval (in milliseconds) the client should heartbeat with
  let heartbeatInterval: UnixTime
}

extension GatewayHello {
  enum CodingKeys: String, CodingKey {
    case heartbeatInterval = "heartbeat_interval"
  }
}
