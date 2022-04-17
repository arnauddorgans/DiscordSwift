// 
// 

import Foundation

public extension Embed {
  /// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-image-structure
  struct Image: Decodable {
    /// Source url of image (only supports http(s) and attachments)
    public let url: String
    /// A proxied url of the image
    public let proxyURL: URL?
    /// Height of image
    public let height: Int?
    /// Width of image
    public let width: Int?
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
