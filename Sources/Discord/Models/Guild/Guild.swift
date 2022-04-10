// 
// 

import Foundation

/// Guilds in Discord represent an isolated collection of users and channels, and are often referred to as "servers" in the UI.
/// - seealso: https://discord.com/developers/docs/resources/guild#guild-object-guild-structure
public struct Guild: Decodable {
  /// Guild id
  public var id: Snowflake
  /// Guild name (2-100 characters, excluding trailing and leading whitespace)
  public let name: String
  /// Icon hash
  public let icon: String?
  /// Icon hash, returned when in the template object
  public let iconHash: String?
  /// Splash hash
  public let splash: String?
  /// Discovery splash hash; only present for guilds with the "DISCOVERABLE" feature
  public let discoverySplash: String?
  /// True if the user is the owner of the guild
  public let owner: Bool?
  /// ID of owner
  public var ownerID: Snowflake
  /// Total permissions for the user in the guild (excludes overwrites)
  public let permissions: Permissions?
  /// Voice region id for the guild (deprecated)
  public let region: String?
  /// ID of afk channel
  public let afkChannelID: Snowflake?
  /// AFK timeout in seconds
  public let afkTimeout: Int
  /// True if the server widget is enabled
  public let widgetEnabled: Bool?
  /// The channel id that the widget will generate an invite to, or null if set to no invite
  public let widgetChannelID: Snowflake?
  /// Verification level required for the guild
  public let verificationLevel: Int
  /// Default message notifications level
  public let defaultMessageNotifications: Int
  /// Explicit content filter level
  public let explicitContentFilter: Int
  /// Roles in the guild
  public let roles: [Role]
  /// Custom guild emojis
  public let emojis: [Emoji]
  /// Enabled guild features
  public let features: [Feature]
  /// Integer  required MFA level for the guild
  public let mfaLevel: MFALevel
  /// Application id of the guild creator if it is bot-created
  public let applicationID: Snowflake?
  /// The id of the channel where guild notices such as welcome messages and boost events are posted
  public let systemChannelID: Snowflake?
  /// System channel flags
  public let systemChannelFlags: SystemChannelFlags
  /// The id of the channel where Community guilds can display rules and/or guidelines
  public let rulesChannelID: Snowflake?
  /// When this guild was joined at
  public let joinedAt: Date?
  /// True if this is considered a large guild
  public let large: Bool?
  /// True if this guild is unavailable due to an outage
  public let unavailable: Bool?
  /// Total number of members in this guild
  public let memberCount: Int?
  /// States of members currently in voice channels; lacks the guild_id key
  public let voiceStates: [VoiceState]?
  /// Users in the guild
  public let members: [Member]?
  /// Channels in the guild
  public let channels: [Channel]?
  /// All active threads in the guild that current user has permission to view
  public let threads: [Channel]?
  /// Presences of the members in the guild, will only include non-offline members if the size is greater than large threshold
  public let presences: [PresenceUpdateEvent]?
  /// The maximum number of presences for the guild (null is always returned, apart from the largest of guilds)
  public let maxPresences: Int?
  /// The maximum number of members for the guild
  public let maxMembers: Int?
  /// The vanity url code for the guild
  public let vanityURLCode: String?
  /// The description of a guild
  public let description: String?
  /// Banner hash
  public let banner: String?
  /// Premium tier (Server Boost level)
  public let premiumTier: PremiumTier
  /// The number of boosts this guild currently has
  public let premiumSubscriptionCount: Int?
  /// The preferred locale of a Community guild; used in server discovery and notices from Discord, and sent in interactions; defaults to "en-US"
  public let preferredLocale: String
  /// The id of the channel where admins and moderators of Community guilds receive notices from Discord
  public let publicUpdatesChannelID: Snowflake?
  /// The maximum amount of users in a video channel
  public let maxVideoChannelUsers: Int?
  /// Approximate number of members in this guild, returned from the GET /guilds/<id> endpoint when with_counts is true
  public let approximateMemberCount: Int?
  /// Approximate number of non-offline members in this guild, returned from the GET /guilds/<id> endpoint when with_counts is true
  public let approximatePresenceCount: Int?
  /// The welcome screen of a Community guild, shown to new members, returned in an Invite's guild object
  public let welcomeScreen: WelcomeScreen?
  /// Guild NSFW level
  public let nsfwLevel: NSFWLevel
  /// Stage instances in the guild
  public let stageInstances: [StageInstance]?
  /// Custom guild stickers
  public let stickers: [Sticker]?
  /// The scheduled events in the guild
  public let guildScheduledEvents: [ScheduledEvent]?
  /// Whether the guild has the boost progress bar enabled
  public let premiumProgressBarEnabled: Bool
}

extension Guild {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case icon
    case iconHash = "icon_hash"
    case splash
    case discoverySplash = "discovery_splash"
    case owner
    case ownerID = "owner_id"
    case permissions
    case region
    case afkChannelID = "afk_channel_id"
    case afkTimeout = "afk_timeout"
    case widgetEnabled = "widget_enabled"
    case widgetChannelID = "widget_channel_id"
    case verificationLevel = "verification_level"
    case defaultMessageNotifications = "default_message_notifications"
    case explicitContentFilter = "explicit_content_filter"
    case roles
    case emojis
    case features
    case mfaLevel = "mfa_level"
    case applicationID = "application_id"
    case systemChannelID = "system_channel_id"
    case systemChannelFlags = "system_channel_flags"
    case rulesChannelID = "rules_channel_id"
    case joinedAt = "joined_at"
    case large
    case unavailable
    case memberCount = "member_count"
    case voiceStates = "voice_states"
    case members
    case channels
    case threads
    case presences
    case maxPresences = "max_presences"
    case maxMembers = "max_members"
    case vanityURLCode = "vanity_url_code"
    case description
    case banner
    case premiumTier = "premium_tier"
    case premiumSubscriptionCount = "premium_subscription_count"
    case preferredLocale = "preferred_locale"
    case publicUpdatesChannelID = "public_updates_channel_id"
    case maxVideoChannelUsers = "max_video_channel_users"
    case approximateMemberCount = "approximate_member_count"
    case approximatePresenceCount = "approximate_presence_count"
    case welcomeScreen = "welcome_screen"
    case nsfwLevel = "nsfw_level"
    case stageInstances = "stage_instances"
    case stickers
    case guildScheduledEvents = "guild_scheduled_events"
    case premiumProgressBarEnabled = "premium_progress_bar_enabled"
  }
}
