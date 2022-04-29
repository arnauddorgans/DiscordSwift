// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/message-components#text-inputs
public struct TextInput: Codable {
  /// A developer-defined identifier for the input, max 100 characters
  public let customID: String
  /// The Text Input Style
  public let style: Style
  /// The label for this component, max 45 characters
  public let label: String
  /// the minimum input length for a text input, min 0, max 4000
  public let minLength: Int?
  /// The maximum input length for a text input, min 1, max 4000
  public let maxLength: Int?
  /// Whether this component is required to be filled, default true
  public let required: Bool?
  /// A pre-filled value for this component, max 4000 characters
  public let value: String?
  /// Custom placeholder text if the input is empty, max 100 characters
  public let placeholder: String?
  
  public init(customID: String,
              style: Style,
              label: String,
              minLength: Int? = nil,
              maxLength: Int? = nil,
              required: Bool? = nil,
              value: String? = nil,
              placeholder: String? = nil) {
    self.customID = customID
    self.style = style
    self.label = label
    self.minLength = minLength
    self.maxLength = maxLength
    self.required = required
    self.value = value
    self.placeholder = placeholder
  }
}

extension TextInput {
  enum CodingKeys: String, CodingKey {
    case customID = "custom_id"
    case style
    case label
    case minLength = "min_length"
    case maxLength = "max_length"
    case required
    case value
    case placeholder
  }
}
