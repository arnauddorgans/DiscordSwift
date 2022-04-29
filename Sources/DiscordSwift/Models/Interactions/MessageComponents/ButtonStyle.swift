// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/message-components#button-object-button-styles
public extension Button {
  enum Style: Int, Codable {
    /// Blurple
    case primary = 1
    /// Grey
    case secondary = 2
    /// Green
    case success = 3
    /// Red
    case danger = 4
    /// Grey, navigates to a URL
    case link = 5
  }
}
