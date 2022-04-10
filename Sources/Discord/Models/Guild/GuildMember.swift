// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild#guild-member-object-guild-member-structure
  struct Member: Decodable {
    /// The user this guild member represents
    public let user: User?
    /// This user's guild nickname
    public let nick: String?
    /// The member's guild avatar hash
    public let avatar: String?
    /// Array of role object ids
    public let roles: [Snowflake]
    /// When the user joined the guild
    public let joinedAt: Date
    /// When the user started boosting the guild
    public let premiumSince: Date?
    /// Whether the user is deafened in voice channels
    public let deaf: Bool
    /// Whether the user is muted in voice channels
    public let mute: Bool
    /// Whether the user has not yet passed the guild's Membership Screening requirements
    public let pending: Bool?
    /// Total permissions of the member in the channel, including overwrites, returned when in the interaction object
    public let permissions: Permissions?
    /// When the user's timeout will expire and the user will be able to communicate in the guild again, null or a time in the past if the user is not timed out
    public let communicationDisabledUntil: Date?
  }
}

extension Guild.Member {
  enum CodingKeys: String, CodingKey {
    case user
    case nick
    case avatar
    case roles
    case joinedAt = "joined_at"
    case premiumSince = "premium_since"
    case deaf
    case mute
    case pending
    case permissions
    case communicationDisabledUntil = "communication_disabled_until"
  }
}
