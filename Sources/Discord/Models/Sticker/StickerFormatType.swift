// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-format-types
public enum StickerFormatType: Int, Decodable {
  case png = 1
  case apng = 2
  case lottie = 3
}
