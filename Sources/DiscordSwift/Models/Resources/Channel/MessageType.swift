// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/channel#message-object-message-types
public enum MessageType: Int, Codable {
  case `default` = 0
  case recipientAdd = 1
  case recipientRemove = 2
  case call = 3
  case channelNameChange = 4
  case channelIconChange = 5
  case channelPinnedMessage = 6
  case guildMemberJoin = 7
  case userPremiumGuildSubscription = 8
  case userPremiumGuildSubscriptionTier1 = 9
  case userPremiumGuildSubscriptionTier2 = 10
  case userPremiumGuildSubscriptionTier3 = 11
  case channelFollowAdd = 12
  case guildDiscoveryDisqualified = 14
  case guildDiscoveryRequalified = 15
  case guildDiscoveryGracePeriodInitialWarning = 16
  case guildDiscoveryGracePeriodFinalWarning = 17
  case threadCreated = 18
  case reply = 19
  case chatInputCommand = 20
  case threadStarterMessage = 21
  case guildInviteReminder = 22
  case contextMenuCommand = 23
}
