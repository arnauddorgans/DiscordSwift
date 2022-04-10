// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/emoji#emoji-object-emoji-structure
  struct Emoji: Decodable {
    /// Emoji id
    public let id: Snowflake?
    /// Emoji name
    public let name: String?
    /// Array of role object ids  roles allowed to use this emoji
    public let roles: [Role]?
    /// User that created this emoji
    public let user: User?
    /// Whether this emoji must be wrapped in colons
    public let requireColons: Bool?
    /// Whether this emoji is managed
    public let managed: Bool?
    /// Whether this emoji is animated
    public let animated: Bool?
    /// Whether this emoji can be used, may be false due to loss of Server Boosts
    public let available: Bool?
  }
}

extension Guild.Emoji {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case roles
    case user
    case requireColons = "require_colons"
    case managed
    case animated
    case available
  }
}
