// 
// 

import Foundation

public extension Message {
  /// - seealso: https://discord.com/developers/docs/resources/channel#message-object-message-activity-types
  enum ActivityType: Int, Codable {
    case join = 1
    case spectate = 2
    case listen = 3
    case joinRequest = 5
  }
}
