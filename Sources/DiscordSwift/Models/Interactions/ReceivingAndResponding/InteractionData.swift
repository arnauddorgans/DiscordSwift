// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-data-structure
public struct InteractionData: Codable {
  /// The ID of the invoked command
  /// - note: Application Command
  public let id: Snowflake?
  /// The name of the invoked command
  /// - note: Application Command
  public let name: String?
  /// The type of the invoked command
  /// - note: Application Command
  public let type: ApplicationCommandType?
  /// Converted users + roles + channels + attachments
  /// - note: Application Command
  public let resolved: Interaction.ResolvedData?
  /// Command interaction data option  the params + values from the user
  /// - note: Application Command
  public let options: [ApplicationCommand.InteractionDataOption]?
  /// The id of the guild the command is registered to
  /// - note: Application Command
  public let guildID: Snowflake?
  /// The custom_id of the component
  /// - note: Component, Modal Submit
  public let customID: String?
  /// The type of the component
  /// - note: Component
  public let componentType: ComponentType?
  /// The values the user selected
  /// - note: Component (Select)
  public let values: [String]?
  /// ID the of user or message targeted by a user or message command
  /// - note: User Command, Message Command
  public let targetID: Snowflake?
  /// The values submitted by the user
  /// - note: Modal Submit
  public let components: [ComponentData]?
}

extension InteractionData {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case type
    case resolved
    case options
    case guildID = "guild_id"
    case customID = "custom_id"
    case componentType = "component_type"
    case values
    case targetID = "target_id"
    case components
  }
}
