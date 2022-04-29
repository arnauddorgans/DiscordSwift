// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/message-components#select-menus
public struct SelectMenu: Codable {
  /// A developer-defined identifier for the select menu, max 100 characters
  public let customID: String
  /// Array of select options  the choices in the select, max 25
  public let options: [Option]
  /// Custom placeholder text if nothing is selected, max 150 characters
  public let placeholder: String?
  /// The minimum number of items that must be chosen; default 1, min 0, max 25
  public let minValues: Int?
  /// The maximum number of items that can be chosen; default 1, max 25
  public let maxValues: Int?
  /// Disable the select, default false
  public let disabled: Bool?
}

extension SelectMenu {
  enum CodingKeys: String, CodingKey {
    case customID = "custom_id"
    case options
    case placeholder
    case minValues = "min_values"
    case maxValues = "max_values"
    case disabled
  }
}
