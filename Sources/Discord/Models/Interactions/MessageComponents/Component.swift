// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/message-components#component-object
public enum Component {
  case actionRow(ActionRow)
  case button(Button)
  case selectMenu(SelectMenu)
  case textInput(TextInput)
}

// MARK: Decodable
extension Component: Decodable {
  public init(from decoder: Decoder) throws {
    let singleContainer = try decoder.singleValueContainer()
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(ComponentType.self, forKey: .type)
    switch type {
    case .actionRow:
      let actionRow = try singleContainer.decode(ActionRow.self)
      self = .actionRow(actionRow)
    case .button:
      let button = try singleContainer.decode(Button.self)
      self = .button(button)
    case .selectMenu:
      let selectMenu = try singleContainer.decode(SelectMenu.self)
      self = .selectMenu(selectMenu)
    case .textInput:
      let textInput = try singleContainer.decode(TextInput.self)
      self = .textInput(textInput)
    }
  }
}

extension Component {
  enum CodingKeys: String, CodingKey {
    case type
  }
}
