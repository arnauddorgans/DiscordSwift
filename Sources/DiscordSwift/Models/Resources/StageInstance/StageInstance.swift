// 
// 

import Foundation

/// A Stage Instance holds information about a live stage.
/// - seealso: https://discord.com/developers/docs/resources/stage-instance#stage-instance-object-stage-instance-structure
public struct StageInstance: Decodable {
  /// The id of this Stage instance
  public let id: Snowflake
  /// The guild id of the associated Stage channel
  public let guildID: Snowflake
  /// The id of the associated Stage channel
  public let channelID: Snowflake
  /// The topic of the Stage instance (1-120 characters)
  public let topic: String
  /// The privacy level of the Stage instance
  public let privacyLevel: PrivacyLevel
  /// Whether or not Stage Discovery is disabled (deprecated)
  public let discoverableDisabled: Bool
  /// The id of the scheduled event for this Stage instance
  public let guildScheduledEventID: Snowflake?
}

extension StageInstance {
  enum CodingKeys: String, CodingKey {
    case id
    case guildID = "guild_id"
    case channelID = "channel_id"
    case topic
    case privacyLevel = "privacy_level"
    case discoverableDisabled = "discoverable_disabled"
    case guildScheduledEventID = "guild_scheduled_event_id"
  }
}
