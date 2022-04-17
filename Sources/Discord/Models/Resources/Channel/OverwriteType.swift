// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/channel#overwrite-object
public enum OverwriteType: Int, Decodable {
  case role = 0
  case member = 1
}
