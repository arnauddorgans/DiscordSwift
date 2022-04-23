// 
// 

import Foundation

public extension Sticker {
  /// The smallest amount of data required to render a sticker. A partial sticker object.
  /// - seealso: https://discord.com/developers/docs/resources/sticker#sticker-item-object-sticker-item-structure
  struct Item: Codable {
    /// ID of the sticker
    public let id: Snowflake
    /// Name of the sticker
    public let name: String
    /// Type of sticker format
    public let formatType: FormatType
  }
}

extension Sticker.Item {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case formatType = "format_type"
  }
}
