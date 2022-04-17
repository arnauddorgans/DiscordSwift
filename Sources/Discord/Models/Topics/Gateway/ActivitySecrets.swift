// 
// 

import Foundation

public extension Activity {
  /// - seealso: https://discord.com/developers/docs/topics/gateway#activity-object-activity-secrets
  struct Secrets: Decodable {
    /// The secret for joining a party
    public let join: String?
    /// The secret for spectating a game
    public let spectate: String?
    /// The secret for a specific instanced match
    public let match: String?
  }
}
