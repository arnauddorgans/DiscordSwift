// 
// 

import Foundation

/// An Interaction is the message that your application receives when a user uses an application command or a message component.
/// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-structure
public struct Interaction: Codable {
  /// ID of the interaction
  public let id: Snowflake
  /// ID of the application this interaction is for
  public let applicationID: Snowflake
  /// The type of interaction
  public let type: InteractionType
  /// The command data payload
  public let data: InteractionData?
  /// The guild it was sent from
  public let guildID: Snowflake?
  /// The channel it was sent from
  public let channelID: Snowflake?
  /// Guild member data for the invoking user, including permissions
  public let member: Guild.Member?
  /// User object for the invoking user, if invoked in a DM
  public let user: User?
  /// A continuation token for responding to the interaction
  public let token: String
  /// Read-only property, always 1
  public let version: Int
  /// For components, the message they were attached to
  public let message: Message?
  /// The selected language of the invoking user
  public let locale: String?
  /// The guild's preferred locale, if invoked in a guild
  public let guildLocale: String?
}

extension Interaction {
  enum CodingKeys: String, CodingKey {
    case id
    case applicationID = "application_id"
    case type
    case data
    case guildID = "guild_id"
    case channelID = "channel_id"
    case member
    case user
    case token
    case version
    case message
    case locale
    case guildLocale = "guild_locale"
  }
}
