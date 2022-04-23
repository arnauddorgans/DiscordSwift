// 
// 

import Foundation

public extension Activity {
  /// - seealso: https://discord.com/developers/docs/topics/gateway#activity-object-activity-buttons
  struct Button: Codable {
    /// The text shown on the button (1-32 characters)
    public let label: String
    /// The url opened when clicking the button (1-512 characters)
    public let url: URL
  }
}
