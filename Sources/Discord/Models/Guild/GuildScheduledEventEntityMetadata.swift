// 
// 

import Foundation

public extension Guild.ScheduledEvent {
  /// - seealso: https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-entity-metadata
  struct EntityMetadata: Decodable {
    /// Location of the event (1-100 characters)
    public let location: String?
  }
}
