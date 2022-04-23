// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/opcodes-and-status-codes#gateway-gateway-opcodes
enum GatewayOpcode: Int, Codable {
  /// An event was dispatched.
  case dispatch = 0
  /// Fired periodically by the client to keep the connection alive.
  case heartbeat = 1
  /// Starts a new session during the initial handshake.
  case identify = 2
  /// Update the client's presence.
  case presenceUpdate = 3
  /// Used to join/leave or move between voice channels.
  case voiceStateUpdate = 4
  /// Send  Resume a previous session that was disconnected.
  case resume = 6
  /// You should attempt to reconnect and resume immediately.
  case reconnect = 7
  /// Send  Request information about offline guild members in a large guild.
  case requestGuildMembers = 8
  /// The session has been invalidated. You should reconnect and identify/resume accordingly.
  case invalidSession = 9
  /// Sent immediately after connecting, contains the heartbeat_interval to use.
  case hello = 10
  /// Sent in response to receiving a heartbeat to acknowledge that it has been received.
  case heartbeatACK = 11
}
