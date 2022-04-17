// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/gateway#client-status-object
public enum ClientStatus: String, Decodable {
  case online
  case idle
  case dnd
}
