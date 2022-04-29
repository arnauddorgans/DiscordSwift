// 
// 

import Foundation

public extension SelectMenu {
  /// - seealso: https://discord.com/developers/docs/interactions/message-components#select-menu-object-select-option-structure
  struct Option: Codable {
    /// The user-facing name of the option, max 100 characters
    public let label: String
    /// The dev-defined value of the option, max 100 characters
    public let value: String
    /// An additional description of the option, max 100 characters
    public let description: String?
    /// id, name, and animated
    public let emoji: Emoji?
    /// Will render this option as selected by default
    public let `default`: Bool?
    
    public init(label: String,
                value: String,
                description: String? = nil,
                emoji: Emoji? = nil,
                `default`: Bool? = nil) {
      self.label = label
      self.value = value
      self.description = description
      self.emoji = emoji
      self.default = `default`
    }
  }
}
