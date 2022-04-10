// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild#guild-preview-object-guild-preview-structure
  struct Preview: Decodable {
    /// Guild id
    public let id: Snowflake
    /// Guild name (2-100 characters)
    public let name: String
    /// Icon hash
    public let icon: String?
    /// Splash hash
    public let splash: String?
    /// Discovery splash hash
    public let discoverySplash: String?
    /// Custom guild emojis
    public let emojis: [Emoji]
    /// Enabled guild features
    public let features: [Feature]
    /// Approximate number of members in this guild
    public let approximateMemberCount: Int
    /// Approximate number of online members in this guild
    public let approximatePresenceCount: Int
    /// The description for the guild
    public let description: String?
    /// Custom guild stickers
    public let stickers: [Sticker]
  }
}

extension Guild.Preview {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case icon
    case splash
    case discoverySplash = "discovery_splash"
    case emojis
    case features
    case approximateMemberCount = "approximate_member_count"
    case approximatePresenceCount = "approximate_presence_count"
    case description
    case stickers
  }
}
