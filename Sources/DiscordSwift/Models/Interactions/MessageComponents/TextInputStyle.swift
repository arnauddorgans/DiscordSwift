// 
// 

import Foundation

public extension TextInput {
  /// - seealso: https://discord.com/developers/docs/interactions/message-components#text-inputs-text-input-styles
  enum Style: Int, Codable {
    /// A single-line input
    case short = 1
    /// A multi-line input
    case paragraph = 2
  }
}
