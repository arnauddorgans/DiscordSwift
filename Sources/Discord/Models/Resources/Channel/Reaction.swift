// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/channel#reaction-object
public struct Reaction: Decodable {
  /// Times this emoji has been used to react
  public let count: Int
  /// Whether the current user reacted using this emoji
  public let me: Bool
  /// Emoji information
  public let emoji: Emoji
}
