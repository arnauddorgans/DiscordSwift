// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/message-components#text-inputs
public struct TextInputData: Codable {
  /// A developer-defined identifier for the input, max 100 characters
  public let customID: String
  /// The value for this component, max 4000 characters
  public let value: String?
  
  public init(customID: String,
              value: String? = nil) {
    self.customID = customID
    self.value = value
  }
}

extension TextInputData {
  enum CodingKeys: String, CodingKey {
    case customID = "custom_id"
    case value
  }
}
