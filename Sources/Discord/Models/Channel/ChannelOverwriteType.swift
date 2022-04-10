// 
// 

import Foundation

public extension Channel {
  enum OverwriteType: Int, Decodable {
    case role = 0
    case member = 1
  }
}
