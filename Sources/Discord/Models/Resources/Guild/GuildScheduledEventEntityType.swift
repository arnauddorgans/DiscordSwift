// 
// 

import Foundation

public extension Guild.ScheduledEvent {
  /// - seealso: https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-entity-types
  enum EntityType: Int, Decodable {
    case stageInstance = 1
    case voice = 2
    case external = 3
  }
}
