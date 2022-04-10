// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/user#connection-object-connection-structure
public struct Connection: Decodable {
  /// ID of the connection account
  public let id: String
  /// The username of the connection account
  public let name: String
  /// The service of the connection (twitch, youtube)
  public let type: String
  /// Whether the connection is revoked
  public let revoked: Bool?
  /// An array of partial server integrations
  public let integrations: [Integration]
  /// Whether the connection is verified
  public let verified: Bool
  /// Whether friend sync is enabled for this connection
  public let friendSync: Bool
  /// Whether activities related to this connection will be shown in presence updates
  public let showActivity: Bool
  /// Visibility of this connection
  public let visibility: Int
}

extension Connection {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case type
    case revoked
    case integrations
    case verified
    case friendSync = "friend_sync"
    case showActivity = "show_activity"
    case visibility
  }
}
