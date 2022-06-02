// 
// 

import Foundation

public extension Embed {
  /// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-footer-structure
  struct Footer: Codable {
    /// Footer text
    public let text: String
    /// URL of footer icon (only supports http(s) and attachments)
    public let iconURL: URL?
    /// A proxied url of footer icon
    public let proxyIconURL: URL?
    
    public init(text: String,
                iconURL: URL? = nil,
                proxyIconURL: URL? = nil) {
      self.text = text
      self.iconURL = iconURL
      self.proxyIconURL = proxyIconURL
    }
  }
}

extension Embed.Footer {
  enum CodingKeys: String, CodingKey {
    case text
    case iconURL = "icon_url"
    case proxyIconURL = "proxy_icon_url"
  }
}
