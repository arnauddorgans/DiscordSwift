// 
// 

import Foundation

public extension PresenceUpdateEvent {
  enum Status: String, Decodable {
    case idle
    case dnd
    case online
    case offline
  }
}
