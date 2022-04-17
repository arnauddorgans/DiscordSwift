// 
// 

import Foundation

public extension Embed {
  /// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-thumbnail-structure
  struct Thumbnail: Decodable {
    /// Source url of thumbnail (only supports http(s) and attachments)
    public let url: URL
    /// A proxied url of the thumbnail
    public let proxyURL: URL?
    /// Height of thumbnail
    public let height: Int?
    /// Width of thumbnail
    public let width: Int?
  }
}

extension Embed.Thumbnail {
  enum CodingKeys: String, CodingKey {
    case url
    case proxyURL = "proxy_url"
    case height
    case width
  }
}
