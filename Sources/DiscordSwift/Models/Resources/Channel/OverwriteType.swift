// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/channel#overwrite-object
public enum OverwriteType: Int, Codable {
  case role = 0
  case member = 1
}
