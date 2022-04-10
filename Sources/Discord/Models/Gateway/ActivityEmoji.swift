// 
// 

import Foundation

public extension Activity {
  /// - seealso: https://discord.com/developers/docs/topics/gateway#activity-object-activity-emoji
  struct Emoji: Decodable {
    /// The name of the emoji
    public let name: String
    /// The id of the emoji
    public let id: Snowflake?
    /// Whether this emoji is animated
    public let animated: Bool?
  }
}
