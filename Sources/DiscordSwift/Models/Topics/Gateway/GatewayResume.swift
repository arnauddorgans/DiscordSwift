// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/gateway#resuming
struct GatewayResume: Codable {
  let token: String
  let sessionID: String
  let sequenceNumber: Int?
}

extension GatewayResume {
  enum CodingKeys: String, CodingKey {
    case token
    case sessionID = "session_id"
    case sequenceNumber = "seq"
  }
}
