// 
// 

import Foundation

public extension Role {
  /// - seealso: https://discord.com/developers/docs/topics/permissions#role-object-role-tags-structure
  struct Tags: Codable {
    /// The id of the bot this role belongs to
    public let botID: Snowflake?
    /// The id of the integration this role belongs to
    public let integrationID: Snowflake?
    /// Whether this is the guild's premium subscriber role
    //public let premium_subscriber: ???
  }
}
