// 
// 

import Foundation

public extension Interaction {
  /// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-resolved-data-structure
  struct ResolvedData: Codable {
    /// The ids and User objects
    public let users: [Snowflake: User]?
    /// The ids and partial Member objects
    public let members: [Snowflake: Guild.Member]?
    /// The ids and Role objects
    public let roles: [Snowflake: Role]?
    /// The ids and partial Channel objects
    public let channels: [Snowflake: Channel]?
    /// The ids and partial Message objects
    public let messages: [Snowflake: Message]?
    /// The ids and attachment objects
    public let attachments: [Snowflake: Attachment]?
  }
}
