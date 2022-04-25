// 
// 

import Foundation

public extension Channel {
  /// - seealso: https://discord.com/developers/docs/resources/channel#channel-mention-object-channel-mention-structure
  struct Mention: Codable {
    /// ID of the channel
    public let id: Snowflake
    /// ID of the guild containing the channel
    public let guildID: Snowflake
    /// The type of channel
    public let type: ChannelType
    /// The name of the channel
    public let name: String
  }
}

extension Channel.Mention {
  enum CodingKeys: String, CodingKey {
    case id
    case guildID = "guild_id"
    case type
    case name
  }
}
