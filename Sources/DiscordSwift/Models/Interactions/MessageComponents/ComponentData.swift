// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/message-components#component-object
/// - note: Support for components in modals is currently limited to type 4 (Text Input).
public enum ComponentData {
  case actionRow(ActionRowData)
  case button
  case selectMenu
  case textInput(TextInputData)
}

private extension ComponentData {
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
extension ComponentData: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Component.CodingKeys.self)
    let type = try container.decode(ComponentType.self, forKey: .type)
    switch type {
    case .actionRow:
      self = try .actionRow(.init(from: decoder))
    case .button:
      self = .button
    case .selectMenu:
      self = .selectMenu
    case .textInput:
      self = try .textInput(.init(from: decoder))
    }
  }
}

// MARK: Encodable
extension ComponentData: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Component.CodingKeys.self)
    try container.encode(type, forKey: .type)
    switch self {
    case let .actionRow(actionRow):
      try actionRow.encode(to: encoder)
    case .button:
      break
    case .selectMenu:
      break
    case let .textInput(textInput):
      try textInput.encode(to: encoder)
    }
  }
}
