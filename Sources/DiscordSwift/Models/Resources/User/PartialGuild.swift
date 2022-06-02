// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/user#get-current-user-guilds-example-partial-guild
public struct PartialGuild: Decodable {
  /// Guild id
  public let id: Snowflake
  /// Guild name (2-100 characters, excluding trailing and leading whitespace)
  public let name: String
  /// Icon hash
  public let icon: String?
  /// True if the user is the owner of the guild
  public let owner: Bool?
  /// Total permissions for the user in the guild (excludes overwrites)
  public let permissions: Permissions?
  /// Enabled guild features
  @SafeArrayCodable
  public private(set) var features: [Guild.Feature]
}
