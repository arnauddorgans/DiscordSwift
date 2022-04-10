// 
// 

import Foundation

/// Represents a sticker that can be sent in messages.
/// - seealso: https://discord.com/developers/docs/resources/sticker#sticker-object-sticker-structure
public struct Sticker: Decodable {
  /// ID of the sticker
  public let id: Snowflake
  /// For standard stickers, id of the pack the sticker is from
  public let packID: Snowflake?
  /// Name of the sticker
  public let name: String
  /// Description of the sticker
  public let description: String?
  /// Autocomplete/suggestion tags for the sticker (max 200 characters)
  public let tags: String
  /// Deprecated previously the sticker asset hash, now an empty string
  public let asset: String?
  /// Type of sticker
  public let type: StickerType
  /// Type of sticker format
  public let formatType: StickerFormatType
  /// Whether this guild sticker can be used, may be false due to loss of Server Boosts
  public let available: Bool?
  /// ID of the guild that owns this sticker
  public let guildID: Snowflake?
  /// User object  the user that uploaded the guild sticker
  public let user: User?
  /// The standard sticker's sort order within its pack
  public let sortValue: Int?
}

extension Sticker {
  enum CodingKeys: String, CodingKey {
    case id
    case packID = "pack_id"
    case name
    case description
    case tags
    case asset
    case type
    case formatType = "format_type"
    case available
    case guildID = "guild_id"
    case user
    case sortValue = "sort_value"
  }
}
