// 
// 

import Foundation

public extension Component {
  /// - seealso: https://discord.com/developers/docs/interactions/message-components#buttons
  struct Button: Codable {
    /// One of button styles
    public let style: Style
    /// Text that appears on the button, max 80 characters
    public let label: String?
    /// Emoji  name, id, and animated
    public let emoji: Emoji?
    /// A developer-defined identifier for the button, max 100 characters
    public let customID: String?
    /// A url for link-style buttons
    public let url: URL?
    /// Whether the button is disabled (default false)
    public let disabled: Bool?
    
    public init(style: Style,
                label: String? = nil,
                emoji: Emoji? = nil,
                customID: String? = nil,
                url: URL? = nil,
                disabled: Bool? = nil) {
      self.style = style
      self.label = label
      self.emoji = emoji
      self.customID = customID
      self.url = url
      self.disabled = disabled
    }
  }
}

extension Component.Button {
  enum CodingKeys: String, CodingKey {
    case style
    case label
    case emoji
    case customID = "custom_id"
    case url
    case disabled
  }
}
