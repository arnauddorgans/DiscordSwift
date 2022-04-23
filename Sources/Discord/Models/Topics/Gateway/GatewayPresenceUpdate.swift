// 
// 

import Foundation

/// Sent by the client to indicate a presence or status update.
/// - seealso: https://discord.com/developers/docs/topics/gateway#update-presence-gateway-presence-update-structure
struct GatewayPresenceUpdate: Codable {
  /// Unix time (in milliseconds) of when the client went idle, or null if the client is not idle
  let since: UnixTime?
  /// The user's activities
  let activities: [Activity]
  /// The user's new status
  let status: String
  /// Whether or not the client is afk
  let afk: Bool
}


