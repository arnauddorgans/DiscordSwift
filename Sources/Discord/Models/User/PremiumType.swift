// 
// 

import Foundation

/// Premium types denote the level of premium a user has.
/// Visit the Nitro page to learn more about the premium plans we currently offer.
/// - seealso: https://discord.com/developers/docs/resources/user#user-object-premium-types
public enum PremiumType: Int, Codable {
  /// None
  case none = 0
  /// Nitro Classic
  case nitroClassic = 1
  /// Nitro
  case nitro = 2
}
