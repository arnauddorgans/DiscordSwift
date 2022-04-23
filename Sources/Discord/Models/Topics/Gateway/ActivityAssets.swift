// 
// 

import Foundation

public extension Activity {
  /// - seealso: https://discord.com/developers/docs/topics/gateway#activity-object-activity-assets
  struct Assets: Codable {
    /// See Activity Asset Image
    public let largeImage: String?
    /// Text displayed when hovering over the large image of the activity
    public let largeText: String?
    /// See Activity Asset Image
    public let smallImage: String?
    /// Text displayed when hovering over the small image of the activity
    public let smallText: String?
  }
}

extension Activity.Assets {
  enum CodingKeys: String, CodingKey {
    case largeImage = "large_image"
    case largeText = "large_text"
    case smallImage = "small_image"
    case smallText = "small_text"
  }
}
