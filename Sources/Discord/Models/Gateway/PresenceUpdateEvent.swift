// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/gateway#presence-update-presence-update-event-fields
public struct PresenceUpdateEvent: Decodable {
  /// - seealso: The user presence is being updated for
  public let user: User
  /// ID of the guild
  public let guildID: Snowflake
  /// Either "idle", "dnd", "online", or "offline"
  public let status: Status
  /// User's current activities
  public let activities: [Activity]
  /// User's platform-dependent status
  public let clientStatus: ClientPlatformStatus
}

extension PresenceUpdateEvent {
  enum CodingKeys: String, CodingKey {
    case user
    case guildID = "guild_id"
    case status
    case activities
    case clientStatus = "client_status"
  }
}
