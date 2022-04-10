// 
// 

import Foundation

public extension Channel {
  /// - seealso: https://discord.com/developers/docs/resources/channel#overwrite-object
  struct Overwrite: Decodable {
    /// Role or user id
    public let id: Snowflake
    /// Either 0 (role) or 1 (member)
    public let type: OverwriteType
    /// Permission bit set
    public let allow: Permissions
    /// Permission bit set
    public let deny: Permissions
  }
}
