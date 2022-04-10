// 
// 

import Foundation

public extension Guild.ScheduledEvent {
  /// - seealso: https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-status
  enum Status: Int, Decodable {
    case scheduled = 1
    case active = 2
    case completed = 3
    case canceled = 4
  }
}
