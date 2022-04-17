// 
// 

import Foundation

public extension Embed {
  /// - seealso: https://discord.com/developers/docs/resources/channel#embed-object-embed-provider-structure
  struct Provider: Decodable {
    /// Name of provider
    public let name: String?
    /// URL of provider
    public let url: URL?
  }
}
