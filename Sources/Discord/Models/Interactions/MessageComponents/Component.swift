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

private extension Component {
  var type: ComponentType {
    switch self {
    case .actionRow:  return .actionRow
    case .button:     return .button
    case .selectMenu: return .selectMenu
    case .textInput:  return .textInput
    }
  }
}

// MARK: Decodable
extension Component: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(ComponentType.self, forKey: .type)
    switch type {
    case .actionRow:
      self = try .actionRow(.init(from: decoder))
    case .button:
      self = try .button(.init(from: decoder))
    case .selectMenu:
      self = try .selectMenu(.init(from: decoder))
    case .textInput:
      self = try .textInput(.init(from: decoder))
    }
  }
}

// MARK: Encodable
extension Component: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(type, forKey: .type)
    switch self {
    case let .actionRow(actionRow):
      try actionRow.encode(to: encoder)
    case let .button(button):
      try button.encode(to: encoder)
    case let .selectMenu(selectMenu):
      try selectMenu.encode(to: encoder)
    case let .textInput(textInput):
      try textInput.encode(to: encoder)
    }
  }
}

extension Component {
  enum CodingKeys: String, CodingKey {
    case type
  }
}
