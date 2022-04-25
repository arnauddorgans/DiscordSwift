// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/message-components#component-object-component-types
public enum ComponentType: Int, Codable {
  /// A container for other components
  case actionRow = 1
  /// A button object
  case button = 2
  /// A select menu for picking from choices
  case selectMenu = 3
  /// A text input object
  case textInput = 4
}
