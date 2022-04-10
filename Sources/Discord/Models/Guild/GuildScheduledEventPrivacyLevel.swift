// 
// 

import Foundation

public extension Guild.ScheduledEvent {
  /// - seealso: https://discord.com/developers/docs/resources/guild-scheduled-event#guild-scheduled-event-object-guild-scheduled-event-privacy-level
  enum PrivacyLevel: Int, Decodable {
    /// The scheduled event is only accessible to guild members
    case guildOnly = 2
  }
}
