// 
// 

import Foundation

public extension Sticker {
  /// - seealso: https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-format-types
  enum FormatType: Int, Codable {
    case png = 1
    case apng = 2
    case lottie = 3
  }
}
