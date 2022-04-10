// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object
  struct ScheduledEvent: Decodable {
    /// The id of the scheduled event
    public let id: Snowflake
    /// The guild id which the scheduled event belongs to
    public let guildID: Snowflake
    /// The channel id in which the scheduled event will be hosted, or null if scheduled entity type is EXTERNAL
    public let channelID: Snowflake?
    /// The id of the user that created the scheduled event
    public let creatorID: Snowflake?
    /// The name of the scheduled event (1-100 characters)
    public let name: String
    /// The description of the scheduled event (1-1000 characters)
    public let description: String?
    /// The time the scheduled event will start
    public let scheduledStartTime: Date
    /// The time the scheduled event will end, required if entity_type is EXTERNAL
    public let scheduledEndTime: Date?
    /// The privacy level of the scheduled event
    public let privacyLevel: PrivacyLevel
    /// The status of the scheduled event
    public let status: Status
    /// The type of the scheduled event
    public let entityType: EntityType
    /// The id of an entity associated with a guild scheduled event
    public let entityID: Snowflake?
    /// Additional metadata for the guild scheduled event
    public let entityMetadata: EntityMetadata
    /// The user that created the scheduled event
    public let creator: User?
    /// The number of users subscribed to the scheduled event
    public let userCount: Int?
    /// The cover image hash of the scheduled event
    public let image: String?
  }
}

extension Guild.ScheduledEvent {
  enum CodingKeys: String, CodingKey {
    case id
    case guildID = "guild_id"
    case channelID = "channel_id"
    case creatorID = "creator_id"
    case name
    case description
    case scheduledStartTime = "scheduled_start_time"
    case scheduledEndTime = "scheduled_end_time"
    case privacyLevel = "privacy_level"
    case status
    case entityType = "entity_type"
    case entityID = "entity_id"
    case entityMetadata = "entity_metadata"
    case creator
    case userCount = "user_count"
    case image
  }
}
