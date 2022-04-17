// 
// 

import Foundation

public extension StageInstance {
  /// - seealso: https://discord.com/developers/docs/resources/stage-instance#stage-instance-object-privacy-level
  enum PrivacyLevel: Int, Decodable {
    /// The Stage instance is visible publicly. (deprecated)
    case `public` = 1
    /// The Stage instance is visible to only guild members.
    case guildOnly = 2
  }
}
