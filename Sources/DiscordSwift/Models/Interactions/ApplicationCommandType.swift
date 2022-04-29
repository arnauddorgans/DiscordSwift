// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-types
public enum ApplicationCommandType: Int, Codable {
  /// Slash commands; a text-based command that shows up when a user types /
  case chatInput = 1
  /// A UI-based command that shows up when you right click or tap on a user
  case user = 2
  /// A UI-based command that shows up when you right click or tap on a message
  case message = 3
}
