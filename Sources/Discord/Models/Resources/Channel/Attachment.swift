// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/channel#attachment-object-attachment-structure
public struct Attachment: Decodable {
  /// Attachment id
  public let id: Snowflake
  /// Name of file attached
  public let filename: String
  /// Description for the file
  public let description: String?
  /// The attachment's media type
  public let contentType: String?
  /// Size of file in bytes
  public let size: Int
  /// Source url of file
  public let url: URL
  /// A proxied url of file
  public let proxyURL: URL
  /// Height of file (if image)
  public let height: Int?
  /// Width of file (if image)
  public let width: Int?
  /// Whether this attachment is ephemeral
  public let ephemeral: Bool?
}

extension Attachment {
  enum CodingKeys: String, CodingKey {
    case id
    case filename
    case description
    case contentType = "content_type"
    case size
    case url
    case proxyURL = "proxy_url"
    case height
    case width
    case ephemeral
  }
}
