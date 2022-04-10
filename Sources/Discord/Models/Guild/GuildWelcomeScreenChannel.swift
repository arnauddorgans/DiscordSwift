// 
// 

import Foundation

public extension Guild.WelcomeScreen {
  /// - seealso: https://discord.com/developers/docs/resources/guild#welcome-screen-object-welcome-screen-channel-structure
  struct Channel: Decodable {
    /// The channel's id
    public let channelID: Snowflake
    /// The description shown for the channel
    public let description: String
    /// The emoji id, if the emoji is custom
    public let emojiID: Snowflake?
    /// The emoji name if custom, the unicode character if standard, or null if no emoji is set
    public let emojiName: String?
  }
}

extension Guild.WelcomeScreen.Channel {
  enum CodingKeys: String, CodingKey {
    case channelID = "channel_id"
    case description
    case emojiID = "emoji_id"
    case emojiName = "emoji_name"
  }
}
