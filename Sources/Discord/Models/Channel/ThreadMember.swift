// 
// 

import Foundation

/// A thread member is used to indicate whether a user has joined a thread or not.
/// - seealso: https://discord.com/developers/docs/resources/channel#thread-member-object-thread-member-structure
public struct ThreadMember: Decodable {
  /// The id of the thread
  public let id: Snowflake?
  /// The id of the user
  public let user_id: Snowflake?
  /// The time the current user last joined the thread
  public let join_timestamp: Date
  /// Any user-thread settings, currently only used for notifications
  public let flags: Int
}


