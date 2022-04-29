// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-structure
public struct ApplicationCommand: Codable {
  /// Unique ID of command
  public let id: Snowflake
  /// One of application command type  Type of command, defaults to 1
  public let type: ApplicationCommandType?
  /// ID of the parent application
  public let application_id: Snowflake
  /// Snowflake  guild id of the command, if not global
  public let guild_id: Snowflake?
  /// Name of command, 1-32 characters
  public let name: String
  /// Localization dictionary for name field. Values follow the same restrictions as name
  public let nameLocalizations: [String: String]?
  /// Description for CHAT_INPUT commands, 1-100 characters. Empty string for USER and MESSAGE commands
  public let description: String
  /// Localization dictionary for description field. Values follow the same restrictions as description
  public let descriptionLocalizations: [String: String]?
  /// Parameters for the command, max of 25
  public let options: [Option]?
  /// Set of permissions represented as a bit set
  public let defaultMemberPermissions: Permissions?
  /// Indicates whether the command is available in DMs with the app, only for globally-scoped commands. By default, commands are visible.
  public let dmPermission: Bool?
  /// Not recommended for use as field will soon be deprecated. Indicates whether the command is enabled by default when the app is added to a guild, defaults to true
  public let defaultPermission: Bool?
  /// Autoincrementing version identifier updated during substantial record changes
  public let version: Snowflake
}

extension ApplicationCommand {
  enum CodingKeys: String, CodingKey {
    case id
    case type
    case application_id = "application_id"
    case guild_id = "guild_id"
    case name
    case nameLocalizations = "name_localizations"
    case description
    case descriptionLocalizations = "description_localizations"
    case options
    case defaultMemberPermissions = "default_member_permissions"
    case dmPermission = "dm_permission"
    case defaultPermission = "default_permission"
    case version
  }
}
