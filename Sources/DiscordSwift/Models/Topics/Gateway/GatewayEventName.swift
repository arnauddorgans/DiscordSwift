// 
// 

import Foundation

/// Events are payloads sent over the socket to a client that correspond to events in Discord.
/// - seealso: https://discord.com/developers/docs/topics/gateway#commands-and-events-gateway-events
public enum GatewayEventName: String, Codable {
  /// Defines the heartbeat interval
  case hello = "HELLO"
  /// Contains the initial state information
  case ready = "READY"
  /// Response to Resume
  case resumed = "RESUMED"
  /// Server is going away, client should reconnect to gateway and resume
  case reconnect = "RECONNECT"
  /// Failure response to Identify or Resume or invalid active session
  case invalidSession = "INVALID_SESSION"
  /// New guild channel created
  case channelCreate = "CHANNEL_CREATE"
  /// Channel was updated
  case channelUpdate = "CHANNEL_UPDATE"
  /// Channel was deleted
  case channelDelete = "CHANNEL_DELETE"
  /// Message was pinned or unpinned
  case channelPinsUpdate = "CHANNEL_PINS_UPDATE"
  /// Thread created, also sent when being added to a private thread
  case threadCreate = "THREAD_CREATE"
  /// Thread was updated
  case threadUpdate = "THREAD_UPDATE"
  /// Thread was deleted
  case threadDelete = "THREAD_DELETE"
  /// Sent when gaining access to a channel, contains all active threads in that channel
  case threadListSync = "THREAD_LIST_SYNC"
  /// Thread member for the current user was updated
  case threadMemberUpdate = "THREAD_MEMBER_UPDATE"
  /// Some user(s) were added to or removed from a thread
  case threadMembersUpdate = "THREAD_MEMBERS_UPDATE"
  /// Lazy-load for unavailable guild, guild became available, or user joined a new guild
  case guildCreate = "GUILD_CREATE"
  /// Guild was updated
  case guildUpdate = "GUILD_UPDATE"
  /// Guild became unavailable, or user left/was removed from a guild
  case guildDelete = "GUILD_DELETE"
  /// User was banned from a guild
  case guildBanAdd = "GUILD_BAN_ADD"
  /// User was unbanned from a guild
  case guildBanRemove = "GUILD_BAN_REMOVE"
  /// Guild emojis were updated
  case guildEmojisUpdate = "GUILD_EMOJIS_UPDATE"
  /// Guild stickers were updated
  case guildStickersUpdate = "GUILD_STICKERS_UPDATE"
  /// Guild integration was updated
  case guildIntegrationsUpdate = "GUILD_INTEGRATIONS_UPDATE"
  /// New user joined a guild
  case guildMemberAdd = "GUILD_MEMBER_ADD"
  /// User was removed from a guild
  case guildMemberRemove = "GUILD_MEMBER_REMOVE"
  /// Guild member was updated
  case guildMemberUpdate = "GUILD_MEMBER_UPDATE"
  /// Response to Request Guild Members
  case guildMembersChunk = "GUILD_MEMBERS_CHUNK"
  /// Guild role was created
  case guildRoleCreate = "GUILD_ROLE_CREATE"
  /// Guild role was updated
  case guildRoleUpdate = "GUILD_ROLE_UPDATE"
  /// Guild role was deleted
  case guildRoleDelete = "GUILD_ROLE_DELETE"
  /// Guild scheduled event was created
  case guildScheduledEventCreate = "GUILD_SCHEDULED_EVENT_CREATE"
  /// Guild scheduled event was updated
  case guildScheduledEventUpdate = "GUILD_SCHEDULED_EVENT_UPDATE"
  /// Guild scheduled event was deleted
  case guildScheduledEventDelete = "GUILD_SCHEDULED_EVENT_DELETE"
  /// User subscribed to a guild scheduled event
  case guildScheduledEventUserAdd = "GUILD_SCHEDULED_EVENT_USER_ADD"
  /// User unsubscribed from a guild scheduled event
  case guildScheduledEventUserRemove = "GUILD_SCHEDULED_EVENT_USER_REMOVE"
  /// Guild integration was created
  case integrationCreate = "INTEGRATION_CREATE"
  /// Guild integration was updated
  case integrationUpdate = "INTEGRATION_UPDATE"
  /// Guild integration was deleted
  case integrationDelete = "INTEGRATION_DELETE"
  /// User used an interaction, such as an Application Command
  case interactionCreate = "INTERACTION_CREATE"
  /// Invite to a channel was created
  case inviteCreate = "INVITE_CREATE"
  /// Invite to a channel was deleted
  case inviteDelete = "INVITE_DELETE"
  /// Message was created
  case messageCreate = "MESSAGE_CREATE"
  /// Message was edited
  case messageUpdate = "MESSAGE_UPDATE"
  /// Message was deleted
  case messageDelete = "MESSAGE_DELETE"
  /// Multiple messages were deleted at once
  case messageDeleteBulk = "MESSAGE_DELETE_BULK"
  /// User reacted to a message
  case messageReactionAdd = "MESSAGE_REACTION_ADD"
  /// User removed a reaction from a message
  case messageReactionRemove = "MESSAGE_REACTION_REMOVE"
  /// All reactions were explicitly removed from a message
  case messageReactionRemoveAll = "MESSAGE_REACTION_REMOVE_ALL"
  /// All reactions for a given emoji were explicitly removed from a message
  case messageReactionRemoveEmoji = "MESSAGE_REACTION_REMOVE_EMOJI"
  /// User was updated
  case presenceUpdate = "PRESENCE_UPDATE"
  /// Stage instance was created
  case stageInstanceCreate = "STAGE_INSTANCE_CREATE"
  /// Stage instance was deleted or closed
  case stateInstanceDelete = "STAGE_INSTANCE_DELETE"
  /// Stage instance was updated
  case stageInstanceUpdate = "STAGE_INSTANCE_UPDATE"
  /// User started typing in a channel
  case typingStart = "TYPING_START"
  /// Properties about the user changed
  case userUpdate = "USER_UPDATE"
  /// Someone joined, left, or moved a voice channel
  case voiceStateUpdate = "VOICE_STATE_UPDATE"
  /// Guild's voice server was updated
  case voiceServerUpdate = "VOICE_SERVER_UPDATE"
  /// guild channel webhook was created, update, or deleted
  case webhooksUpdate = "WEBHOOKS_UPDATE"
}
