// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild#guild-object-premium-tier
  enum PremiumTier: Int, Decodable {
    /// Guild has not unlocked any Server Boost perks
    case none = 0
    /// Guild has unlocked Server Boost level 1 perks
    case tier1 = 1
    /// Guild has unlocked Server Boost level 2 perks
    case tier2 = 2
    /// Guild has unlocked Server Boost level 3 perks
    case tier3 = 3
  }
}
