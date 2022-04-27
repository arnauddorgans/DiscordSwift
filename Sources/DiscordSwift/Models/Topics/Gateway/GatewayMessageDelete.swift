// 
// 

import Foundation

/// Sent when a message is deleted.
/// - seealso: https://discord.com/developers/docs/topics/gateway#message-delete-message-delete-event-fields
public struct GatewayMessageDelete: Codable {
  /// The id of the message
  public let id: Snowflake
  /// The id of the channel
  public let channelID: Snowflake
  /// The id of the guild
  public let guildID: Snowflake?
}

extension GatewayMessageDelete {
  enum CodingKeys: String, CodingKey {
    case id
    case channelID = "channel_id"
    case guildID = "guild_id"
  }
}
