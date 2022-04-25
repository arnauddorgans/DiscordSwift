// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild#guild-object-default-message-notification-level
  enum DefaultMessageNotificationLevel: Int, Decodable {
    /// Members will receive notifications for all messages by default
    case allMessages = 0
    /// Members will receive notifications only for messages that @mention them by default
    case onlyMentions = 1
  }
}
