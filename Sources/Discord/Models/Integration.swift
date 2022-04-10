// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/guild#integration-object-integration-structure
public struct Integration: Decodable {
  /// Integration id
  public let id: Snowflake
  /// Integration name
  public let name: String
  /// Integration type (twitch, youtube, or discord)
  public let type: String
  /// Is this integration enabled
  public let enabled: Bool
  /// Is this integration syncing
  public let syncing: Bool?
  /// ID that this integration uses for "subscribers"
  public let roleID: Snowflake?
  /// Whether emoticons should be synced for this integration (twitch only currently)
  public let enableEmoticons: Bool?
  /// Integration expire behavior  the behavior of expiring subscribers
  public let expireBehavior: ExpireBehavior?
  /// The grace period (in days) before expiring subscribers
  public let expireGracePeriod: Int?
  /// User for this integration
  public let user: User?
  /// Integration account information
  public let account: Account
  /// When this integration was last synced
  public let syncedAt: Date?
  /// How many subscribers this integration has
  public let subscriberCount: Int?
  /// Has this integration been revoked
  public let revoked: Bool?
  /// The bot/OAuth2 application for discord integrations
  public let application: Application?
}

extension Integration {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case type
    case enabled
    case syncing
    case roleID = "role_id"
    case enableEmoticons = "enable_emoticons"
    case expireBehavior = "expire_behavior"
    case expireGracePeriod = "expire_grace_period"
    case user
    case account
    case syncedAt = "synced_at"
    case subscriberCount = "subscriber_count"
    case revoked
    case application
  }
}
