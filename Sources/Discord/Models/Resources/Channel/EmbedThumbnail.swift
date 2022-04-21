// 
// 

import Foundation

public extension Embed {
  /// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-thumbnail-structure
  struct Thumbnail: Codable {
    /// Source url of thumbnail (only supports http(s) and attachments)
    public let url: URL
    /// A proxied url of the thumbnail
    public let proxyURL: URL?
    /// Height of thumbnail
    public let height: Int?
    /// Width of thumbnail
    public let width: Int?
    
    public init(url: URL,
                proxyURL: URL? = nil,
                height: Int? = nil,
                width: Int? = nil) {
      self.url = url
      self.proxyURL = proxyURL
      self.height = height
      self.width = width
    }
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
