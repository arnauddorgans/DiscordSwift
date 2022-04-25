// 
// 

import Foundation

public extension Embed {
  /// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-image-structure
  struct Image: Codable {
    /// Source url of image (only supports http(s) and attachments)
    public let url: URL
    /// A proxied url of the image
    public let proxyURL: URL?
    /// Height of image
    public let height: Int?
    /// Width of image
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

extension Embed.Image {
  enum CodingKeys: String, CodingKey {
    case url
    case proxyURL = "proxy_url"
    case height
    case width
  }
}
