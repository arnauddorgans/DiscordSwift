// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/gateway#activity-object
public struct Activity: Decodable {
  /// The activity's name
  public let name: String
  /// Activity type
  public let type: ActivityType
  /// Stream url, is validated when type is 1
  public let url: URL?
  /// Unix timestamp (in milliseconds) of when the activity was added to the user's session
  public let createdAt: UnixTimestamp
  /// Unix timestamps for start and/or end of the game
  public let timestamps: Timestamps?
  /// Application id for the game
  public let applicationID: Snowflake?
  /// What the player is currently doing
  public let details: String?
  /// The user's current party status
  public let state: String?
  /// The emoji used for a custom status
  public let emoji: Emoji?
  /// Information for the current party of the player
  public let party: Party?
  /// Images for the presence and their hover texts
  public let assets: Assets?
  /// Secrets for Rich Presence joining and spectating
  public let secrets: Secrets?
  /// Whether or not the activity is an instanced game session
  public let instance: Bool?
  /// Activity flags ORd together, describes what the payload includes
  public let flags: Flags?
  /// The custom buttons shown in the Rich Presence (max 2)
  public let buttons: [Button]?
}

extension Activity {
  enum CodingKeys: String, CodingKey {
    case name
    case type
    case url
    case createdAt = "created_at"
    case timestamps
    case applicationID = "application_id"
    case details
    case state
    case emoji
    case party
    case assets
    case secrets
    case instance
    case flags
    case buttons
  }
}
