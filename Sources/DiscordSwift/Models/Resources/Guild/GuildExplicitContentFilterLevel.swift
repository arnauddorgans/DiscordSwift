// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild#guild-object-explicit-content-filter-level
  enum ExplicitContentFilterLevel: Int, Decodable {
    /// Media content will not be scanned
    case disabled = 0
    /// Media content sent by members without roles will be scanned
    case membersWithoutRoles = 1
    /// Media content sent by all members will be scanned
    case allMembers = 2
  }
}
