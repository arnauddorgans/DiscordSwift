// 
// 

import Foundation

public extension Interaction {
  /// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-data-structure
  enum CallbackData {
    case message(CallbackMessage)
    case autocomplete(CallbackAutocomplete)
    case modal(CallbackModal)
  }
}

// MARK: Encodable
extension Interaction.CallbackData: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case let .message(message):
      try container.encode(message)
    case let .autocomplete(autocomplete):
      try container.encode(autocomplete)
    case let .modal(modal):
      try container.encode(modal)
    }
  }
}
