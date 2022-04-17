// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-structure
public struct Embed: Decodable {
  /// Title of embed
  public let title: String?
  /// Description of embed
  public let description: String?
  /// URL of embed
  public let url: URL?
  /// Timestamp  timestamp of embed content
  public let timestamp: Date?
  /// Color code of the embed
  public let color: Color?
  /// Embed footer object  footer information
  public let footer: Footer?
  /// Embed image object  image information
  public let image: Image?
  /// Embed thumbnail object  thumbnail information
  public let thumbnail: Thumbnail?
  /// Embed video object  video information
  public let video: Video?
  /// Embed provider object  provider information
  public let provider: Provider?
  /// embed author object  author information
  public let author: Author?
  /// array of embed field objects  fields information
  public let fields: [Field]?
}
