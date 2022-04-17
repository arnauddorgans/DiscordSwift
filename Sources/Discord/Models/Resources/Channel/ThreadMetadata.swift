// 
// 

import Foundation

/// The thread metadata object contains a number of thread-specific channel fields that are not needed by other channel types.
/// - seealso: https://discord.com/developers/docs/resources/channel#thread-metadata-object-thread-metadata-structure
public struct ThreadMetadata: Decodable {
  /// Whether the thread is archived
  public let archived: Bool
  /// Duration in minutes to automatically archive the thread after recent activity, can be set to: 60, 1440, 4320, 10080
  public let autoArchiveDuration: Int
  /// Timestamp when the thread's archive status was last changed, used for calculating recent activity
  public let archiveTimestamp: Date
  /// Whether the thread is locked; when a thread is locked, only users with MANAGE_THREADS can unarchive it
  public let locked: Bool
  /// Whether non-moderators can add other non-moderators to a thread; only available on private threads
  public let invitable: Bool?
  /// Timestamp when the thread was created; only populated for threads created after 2022-01-09
  public let createTimestamp: Date?
}

extension ThreadMetadata {
  enum CodingKeys: String, CodingKey {
    case archived
    case autoArchiveDuration = "auto_archive_duration"
    case archiveTimestamp = "archive_timestamp"
    case locked
    case invitable
    case createTimestamp = "create_timestamp"
  }
}
