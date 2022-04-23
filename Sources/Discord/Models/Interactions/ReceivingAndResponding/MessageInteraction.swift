// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#message-interaction-object-message-interaction-structure
public struct MessageInteraction: Codable {
  /// ID of the interaction
  public let id: Snowflake
  /// The type of interaction
  public let type: InteractionType
  /// The name of the application command
  public let name: String
  /// The user who invoked the interaction
  public let user: User
  /// The member who invoked the interaction in the guild
  public let member: Guild.Member?
}
