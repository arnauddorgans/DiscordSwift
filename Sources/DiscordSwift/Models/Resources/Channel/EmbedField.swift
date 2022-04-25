// 
// 

import Foundation

public extension Embed {
  /// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-field-structure
  struct Field: Codable {
    /// Name of the field
    public let name: String
    /// Value of the field
    public let value: String
    /// Whether or not this field should display inline
    public let inline: Bool?
    
    public init(name: String,
                value: String,
                inline: Bool? = nil) {
      self.name = name
      self.value = value
      self.inline = inline
    }
  }
}
