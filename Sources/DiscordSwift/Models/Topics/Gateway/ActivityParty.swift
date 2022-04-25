// 
// 

import Foundation

public extension Activity {
  /// - seealso: https://discord.com/developers/docs/topics/gateway#activity-object-activity-party
  struct Party: Codable {
    /// The id of the party
    public let id: String?
    /// Used to show the party's current and maximum size
    public let size: Size?
  }
}
