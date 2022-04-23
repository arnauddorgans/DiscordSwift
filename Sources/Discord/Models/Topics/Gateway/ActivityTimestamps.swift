// 
// 

import Foundation

public extension Activity {
  /// - seealso: https://discord.com/developers/docs/topics/gateway#activity-object-activity-timestamps
  struct Timestamps: Codable {
    /// Unix time (in milliseconds) of when the activity started
    public let start: UnixTimestamp?
    /// Unix time (in milliseconds) of when the activity ends
    public let end: UnixTimestamp?
  }
}
