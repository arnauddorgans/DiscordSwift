// 
// 

import Foundation

public extension Embed {
  /// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-author-structure
  struct Author: Decodable {
    /// Name of author
    public let name: String
    /// URL of author
    public let url: URL?
    /// URL of author icon (only supports http(s) and attachments)
    public let iconURL: URL?
    /// A proxied url of author icon
    public let proxyIconURL: URL?
  }
}

extension Embed.Author {
  enum CodingKeys: String, CodingKey {
    case name
    case url
    case iconURL = "icon_url"
    case proxyIconURL = "proxy_icon_url"
  }
}
