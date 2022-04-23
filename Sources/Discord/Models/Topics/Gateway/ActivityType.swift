// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/gateway#activity-object-activity-types
public enum ActivityType: Int, Codable {
  /// Playing {name}
  case game = 0
  /// Streaming {details}
  case streaming = 1
  /// Listening to {name}
  case listening = 2
  /// Watching {name}
  case watching = 3
  /// {emoji} {name}
  case custom = 4
  /// Competing in {name}
  case competing = 5
}
