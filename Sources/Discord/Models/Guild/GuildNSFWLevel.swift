// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild#guild-object-guild-nsfw-level
  enum NSFWLevel: Int, Decodable {
    case `default` = 0
    case explicit = 1
    case safe = 2
    case ageRestricted = 3
  }
}
