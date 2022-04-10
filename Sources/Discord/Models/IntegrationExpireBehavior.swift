// 
// 

import Foundation

public extension Integration {
  /// - seealso: https://discord.com/developers/docs/resources/guild#integration-object-integration-expire-behaviors
  enum ExpireBehavior: Int, Codable {
    /// Remove role
    case removeRole = 0
    /// Kick
    case kick = 1
  }
}
