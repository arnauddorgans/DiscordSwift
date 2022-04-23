// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/gateway#session-start-limit-object-session-start-limit-structure
struct SessionStartLimit: Decodable {
  /// The total number of session starts the current user is allowed
  let total: Int
  /// The remaining number of session starts the current user is allowed
  let remaining: Int
  /// The number of milliseconds after which the limit resets
  let resetAfter: UnixTime
  /// The number of identify requests allowed per 5 seconds
  let maxConcurrency: Int
}

extension SessionStartLimit {
  enum CodingKeys: String, CodingKey {
    case total
    case remaining
    case resetAfter = "reset_after"
    case maxConcurrency = "max_concurrency"
  }
}
