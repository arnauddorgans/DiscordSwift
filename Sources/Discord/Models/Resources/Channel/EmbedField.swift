// 
// 

import Foundation

public extension Embed {
  /// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-field-structure
  struct Field: Decodable {
    /// Name of the field
    public let name: String
    /// Value of the field
    public let value: String
    /// Whether or not this field should display inline
    public let inline: Bool?
  }
}
