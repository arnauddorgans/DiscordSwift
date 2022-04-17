// 
// 

import Foundation

public extension Message {
  /// - seealso: https://discord.com/developers/docs/resources/channel#message-reference-object-message-reference-structure
  struct Reference: Decodable {
    /// ID of the originating message
    public let messageID: Snowflake?
    /// ID of the originating message's channel
    public let channelID: Snowflake?
    /// ID of the originating message's guild
    public let guildID: Snowflake?
    /// When sending, whether to error if the referenced message doesn't exist instead of sending as a normal (non-reply) message, default true
    public let failIfNotExists: Bool?
  }
}

extension Message.Reference {
  enum CodingKeys: String, CodingKey {
    case messageID = "message_id"
    case channelID = "channel_id"
    case guildID = "guild_id"
    case failIfNotExists = "fail_if_not_exists"
  }
}
