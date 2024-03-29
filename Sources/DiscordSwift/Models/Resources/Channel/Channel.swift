// 
// 

import Foundation

/// Represents a guild or DM channel within Discord.
/// - seealso: https://discord.com/developers/docs/resources/channel#channel-object-channel-structure
public struct Channel: Codable {
  /// The id of this channel
  public let id: Snowflake
  /// The type of channel
  public let type: ChannelType
  /// The id of the guild (may be missing for some channel objects received over gateway guild dispatches)
  public let guildID: Snowflake?
  /// Sorting position of the channel
  public let position: Int?
  /// Explicit permission overwrites for members and roles
  public let permissionOverwrites: [Overwrite]?
  /// The name of the channel (1-100 characters)
  public let name: String?
  /// The channel topic (0-1024 characters)
  public let topic: String?
  /// Whether the channel is nsfw
  public let nsfw: Bool?
  /// The id of the last message sent in this channel (or thread for GUILD_FORUM channels) (may not point to an existing or valid message or thread)
  public let lastMessageID: Snowflake?
  /// The bitrate (in bits) of the voice channel
  public let bitrate: Int?
  /// The user limit of the voice channel
  public let userLimit: Int?
  /// Amount of seconds a user has to wait before sending another message (0-21600); bots, as well as users with the permission manage_messages or manage_channel, are unaffected
  public let rateLimitPerUser: Int?
  /// The recipients of the DM
  public let recipients: [User]?
  /// Icon hash of the group DM
  public let icon: String?
  /// ID of the creator of the group DM or thread
  public let ownerID: Snowflake?
  /// Application id of the group DM creator if it is bot-created
  public let applicationID: Snowflake?
  /// For guild channels: id of the parent category for a channel (each parent category can contain up to 50 channels), for threads: id of the text channel this thread was created
  public let parentID: Snowflake?
  /// When the last pinned message was pinned. This may be null in events such as GUILD_CREATE when a message is not pinned.
  public let lastPinTimestamp: Date?
  /// Voice region id for the voice channel, automatic when set to null
  public let rtcRegion: String?
  /// The camera video quality mode of the voice channel, 1 when not present
  public let videoQualityMode: VideoQualityMode?
  /// An approximate count of messages in a thread, stops counting at 50
  public let messageCount: Int?
  /// An approximate count of users in a thread, stops counting at 50
  public let memberCount: Int?
  /// Thread-specific fields not needed by other channels
  public let threadMetadata: ThreadMetadata?
  /// A thread member object  thread member object for the current user, if they have joined the thread, only included on certain API endpoints
  public let member: ThreadMember?
  /// Default duration that the clients (not the API) will use for newly created threads, in minutes, to automatically archive the thread after recent activity, can be set to: 60, 1440, 4320, 10080
  public let defaultAutoArchiveDuration: Int?
  /// Computed permissions for the invoking user in the channel, including overwrites, only included when part of the resolved data received on a slash command interaction
  public let permissions: Permissions?
  /// Channel flags combined as a bitfield
  public let flags: Flags?
}

extension Channel {
  enum CodingKeys: String, CodingKey {
    case id
    case type
    case guildID = "guild_id"
    case position
    case permissionOverwrites = "permission_overwrites"
    case name
    case topic
    case nsfw
    case lastMessageID = "last_message_id"
    case bitrate
    case userLimit = "user_limit"
    case rateLimitPerUser = "rate_limit_per_user"
    case recipients
    case icon
    case ownerID = "owner_id"
    case applicationID = "application_id"
    case parentID = "parent_id"
    case lastPinTimestamp = "last_pin_timestamp"
    case rtcRegion = "rtc_region"
    case videoQualityMode = "video_quality_mode"
    case messageCount = "message_count"
    case memberCount = "member_count"
    case threadMetadata = "thread_metadata"
    case member
    case defaultAutoArchiveDuration = "default_auto_archive_duration"
    case permissions
    case flags
  }
}
