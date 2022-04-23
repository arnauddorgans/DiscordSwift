// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-types
public enum StickerType: Int, Codable {
  /// An official sticker in a pack, part of Nitro or in a removed purchasable pack
  case standard = 1
  /// A sticker uploaded to a Boosted guild for the guild's members
  case guild = 2
}
