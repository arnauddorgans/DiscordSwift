// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild#guild-object-mfa-level
  enum MFALevel: Int, Decodable {
    /// Guild has no MFA/2FA requirement for moderation actions
    case none = 0
    /// Guild has a 2FA requirement for moderation actions
    case elevated = 1
  }
}
