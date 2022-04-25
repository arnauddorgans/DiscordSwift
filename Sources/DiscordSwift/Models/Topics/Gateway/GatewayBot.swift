// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/gateway#get-gateway-bot-json-response
struct GatewayBot: Decodable {
  /// The WSS URL that can be used for connecting to the gateway
  let url: URL
  /// The recommended number of shards to use when connecting
  let shards: Int
  /// Information on the current session start limit
  let sessionStartLimit: SessionStartLimit
}

extension GatewayBot {
  enum CodingKeys: String, CodingKey {
    case url
    case shards
    case sessionStartLimit = "session_start_limit"
  }
}
