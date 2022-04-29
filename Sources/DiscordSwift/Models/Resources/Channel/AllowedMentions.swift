// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/channel#allowed-mentions-object-allowed-mentions-structure
public struct AllowedMentions: Codable {
  /// An array of allowed mention types to parse from the content.
  public let parse: [AllowedMentionType]
  /// Array of role_ids to mention (Max size of 100)
  public let roles: [Snowflake]
  /// Array of user_ids to mention (Max size of 100)
  public let users: [Snowflake]
  /// For replies, whether to mention the author of the message being replied to (default false)
  public let repliedUser: Bool
}

extension AllowedMentions {
  enum CodingKeys: String, CodingKey {
    case parse
    case roles
    case users
    case repliedUser = "replied_user"
  }
}
