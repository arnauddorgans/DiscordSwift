// 
// 

import Foundation

public extension Role {
  struct Tags: Decodable {
    /// The id of the bot this role belongs to
    public let botID: Snowflake?
    /// The id of the integration this role belongs to
    public let integrationID: Snowflake?
    /// Whether this is the guild's premium subscriber role
    //public let premium_subscriber: ???
  }
}
