// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes
public enum OAuth2Scope: String, Decodable {
  /// Allows your app to fetch data from a user's "Now Playing/Recently Played" list - requires Discord approval
  case activitiesRead = "activities.read"
  /// Allows your app to update a user's activity - requires Discord approval (NOT REQUIRED FOR GAMESDK ACTIVITY MANAGER)
  case activitiesWrite = "activities.write"
  /// Allows your app to read build data for a user's applications
  case applicationsBuildsRead = "applications.builds.read"
  /// Allows your app to upload/update builds for a user's applications - requires Discord approval
  case applicationsBuildsUpload = "applications.builds.upload"
  /// Allows your app to use commands in a guild
  case applicationsCommands = "applications.commands"
  /// Allows your app to update its commands via this bearer token - client credentials grant only
  case applicationsCommandsUpdate = "applications.commands.update"
  /// Allows your app to read entitlements for a user's applications
  case applicationsEntitlements = "applications.entitlements"
  /// Allows your app to read and update store data (SKUs, store listings, achievements, etc.) for a user's applications
  case applicationsStoreUpdate = "applications.store.update"
  /// For oauth2 bots, this puts the bot in the user's selected guild by default
  case bot
  /// Allows /users/@me/connections to return linked third-party accounts
  case connections
  /// Enables /users/@me to return an email
  case email
  /// Allows your app to join users to a group dm
  case gdmJoin = "gdm.join"
  /// Allows /users/@me/guilds to return basic information about all of a user's guilds
  case guilds
  /// Allows /guilds/{guild.id}/members/{user.id} to be used for joining users to a guild
  case guildsJoin = "guilds.join"
  /// Allows /users/@me/guilds/{guild.id}/member to return a user's member information in a guild
  case guildsMembersRead = "guilds.members.read"
  /// Allows /users/@me without email
  case identify
  /// For local rpc server api access, this allows you to read messages from all client channels (otherwise restricted to channels/guilds your app creates)
  case messagesRead = "messages.read"
  /// Allows your app to know a user's friends and implicit relationships - requires Discord approval
  case relationshipsRead = "relationships.read"
  /// For local rpc server access, this allows you to control a user's local Discord client - requires Discord approval
  case rpc
  /// For local rpc server access, this allows you to update a user's activity - requires Discord approval
  case rpcActivitiesWrite = "rpc.activities.write"
  /// For local rpc server access, this allows you to receive notifications pushed out to the user - requires Discord approval
  case rpcNotificationsRead = "rpc.notifications.read"
  /// For local rpc server access, this allows you to read a user's voice settings and listen for voice events - requires Discord approval
  case rpcVoiceRead = "rpc.voice.read"
  /// For local rpc server access, this allows you to update a user's voice settings - requires Discord approval
  case rpcVoiceWrite = "rpc.voice.write"
  /// This generates a webhook that is returned in the oauth token response for authorization code grants
  case webhookIncoming = "webhook.incoming"
}
