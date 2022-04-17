// 
// 

import Foundation

public extension Message {
  /// - seealso: https://discord.com/developers/docs/resources/channel#message-object-message-activity-structure
  struct Activity: Decodable {
    /// Type of message activity
    public let type: ActivityType
    /// Party_id from a Rich Presence event
    public let partyID: String?
  }
}

extension Message.Activity {
  enum CodingKeys: String, CodingKey {
    case type
    case partyID = "party_id"
  }
}
