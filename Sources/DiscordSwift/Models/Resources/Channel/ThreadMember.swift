// 
// 

import Foundation

/// A thread member is used to indicate whether a user has joined a thread or not.
/// - seealso: https://discord.com/developers/docs/resources/channel#thread-member-object-thread-member-structure
public struct ThreadMember: Codable {
  /// The id of the thread
  public let id: Snowflake?
  /// The id of the user
  public let userID: Snowflake?
  /// The time the current user last joined the thread
  public let joinTimestamp: Date
  /// Any user-thread settings, currently only used for notifications
  public let flags: ThreadFlags
}

extension ThreadMember {
  enum CodingKeys: String, CodingKey {
    case id
    case userID = "user_id"
    case joinTimestamp = "join_timestamp"
    case flags
  }
}
