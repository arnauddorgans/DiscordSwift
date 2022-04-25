// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/gateway#identify-identify-connection-properties
public struct GatewayConnectionProperties: Codable {
  /// Your operating system
  let os: String
  /// Your library name
  let browser: String
  /// Your library name
  let device: String
}

extension GatewayConnectionProperties {
  enum CodingKeys: String, CodingKey {
    case os = "$os"
    case browser = "$browser"
    case device = "$devic"
  }
}
