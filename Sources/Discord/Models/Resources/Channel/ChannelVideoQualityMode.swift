// 
// 

import Foundation

public extension Channel {
  /// - seealso: https://discord.com/developers/docs/resources/channel#channel-object-video-quality-modes
  enum VideoQualityMode: Int, Codable {
    /// Discord chooses the quality for optimal performance
    case auto = 1
    /// 720p
    case full = 2
  }
}

