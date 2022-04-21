// 
// 

import Foundation

public extension Embed {
  /// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-video-structure
  struct Video: Codable {
    /// Source url of video
    public let url: URL?
    /// A proxied url of the video
    public let proxyURL: URL?
    /// Height of video
    public let height: Int?
    /// Width of video
    public let width: Int?
  }
}

extension Embed.Video {
  enum CodingKeys: String, CodingKey {
    case url
    case proxyURL = "proxy_url"
    case height
    case width
  }
}
