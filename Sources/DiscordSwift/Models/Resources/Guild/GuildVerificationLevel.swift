// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild#guild-object-verification-level
  enum VerificationLevel: Int, Decodable {
    /// Unrestricted
    case none = 0
    /// Must have verified email on account
    case low = 1
    /// Must be registered on Discord for longer than 5 minutes
    case medium = 2
    /// Must be a member of the server for longer than 10 minutes
    case high = 3
    /// Must have a verified phone number
    case veryHigh = 4
  }
}
