// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/channel#channel-object-channel-types
public enum ChannelType: Int, Codable {
  /// A text channel within a server
  case guildText = 0
  /// A direct message between users
  case dm = 1
  /// A voice channel within a server
  case guildVoice = 2
  /// A direct message between multiple users
  case groupDM = 3
  /// An organizational category that contains up to 50 channels
  case guildCategory = 4
  /// A channel that users can follow and crosspost into their own server
  case guildNews = 5
  /// A temporary sub-channel within a GUILD_NEWS channel
  case guildNewsThread = 10
  /// A temporary sub-channel within a GUILD_TEXT channel
  case guildPublicThread = 11
  /// A temporary sub-channel within a GUILD_TEXT channel that is only viewable by those invited and those with the MANAGE_THREADS permission
  case guildPrivateThread = 12
  /// A voice channel for hosting events with an audience
  case guildStageVoice = 13
  /// The channel in a hub containing the listed servers
  case guildDirectory = 14
  /// (still in development) a channel that can only contain threads
  case guildForum = 15
}
