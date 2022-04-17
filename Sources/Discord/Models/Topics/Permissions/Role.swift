// 
// 

import Foundation

/// Roles represent a set of permissions attached to a group of users.
/// Roles have names, colors, and can be "pinned" to the side bar, causing their members to be listed separately.
/// Roles can have separate permission profiles for the global context (guild) and channel context.
/// The @everyone role has the same ID as the guild it belongs to.
/// - seealso: https://discord.com/developers/docs/topics/permissions#role-object-role-structure
public struct Role: Decodable {
  /// Role id
  public let id: Snowflake
  /// Role name
  public let name: String
  /// Integer representation of hexadecimal color code
  public let color: Color
  /// If this role is pinned in the user listing
  public let hoist: Bool
  /// Role icon hash
  public let icon: String?
  /// Role unicode emoji
  public let unicodeEmoji: String?
  /// Position of this role
  public let position: Int
  /// Permission bit set
  public let permissions: Permissions
  /// Whether this role is managed by an integration
  public let managed: Bool
  /// Whether this role is mentionable
  public let mentionable: Bool
  /// The tags this role has
  public let tags: Tags?
}

extension Role {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case color
    case hoist
    case icon
    case unicodeEmoji = "unicode_emoji"
    case position
    case permissions
    case managed
    case mentionable
    case tags
  }
}
