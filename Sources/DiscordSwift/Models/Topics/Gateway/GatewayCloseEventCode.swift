// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/opcodes-and-status-codes#gateway-gateway-close-event-codes
enum GatewayCloseEventCode: Int {
  /// Unknown error  We're not sure what went wrong. Try reconnecting?
  case unknownError = 4000
  /// Unknown opcode  You sent an invalid Gateway opcode or an invalid payload for an opcode. Don't do that!
  case unknownOpcode = 4001
  /// Decode error  You sent an invalid payload to us. Don't do that!
  case decodeError = 4002
  /// Not authenticated  You sent us a payload prior to identifying.
  case notAuthenticated = 4003
  /// Authentication failed  The account token sent with your identify payload is incorrect.
  case authenticationFailed = 4004
  /// Already authenticated  You sent more than one identify payload. Don't do that!
  case alreadyAuthenticated = 4005
  /// Invalid seq  The sequence sent when resuming the session was invalid. Reconnect and start a new session.
  case invalidSequence = 4007
  /// Rate limited  Woah nelly! You're sending payloads to us too quickly. Slow it down! You will be disconnected on receiving this.
  case rateLimited = 4008
  /// Session timed out  Your session timed out. Reconnect and start a new one.
  case sessionTimedOut = 4009
  /// Invalid shard  You sent us an invalid shard when identifying.
  case invalidShard = 4010
  /// Sharding required  The session would have handled too many guilds - you are required to shard your connection in order to connect.
  case shardingRequired = 4011
  /// Invalid API version  You sent an invalid version for the gateway.
  case invalidAPIVersion = 4012
  /// Invalid intent(s)  You sent an invalid intent for a Gateway Intent. You may have incorrectly calculated the bitwise value.
  case invalidIntent = 4013
  /// Disallowed intent(s)  You sent a disallowed intent for a Gateway Intent. You may have tried to specify an intent that you have not enabled or are not approved for.
  case disallowedIntent = 4014
  
  var shouldReconnect: Bool {
    switch self {
    case .unknownError,
        .unknownOpcode,
        .decodeError,
        .notAuthenticated,
        .alreadyAuthenticated,
        .invalidSequence,
        .rateLimited,
        .sessionTimedOut:
      return true
    case .authenticationFailed,
        .invalidShard,
        .shardingRequired,
        .invalidAPIVersion,
        .invalidIntent,
        .disallowedIntent:
      return false
    }
  }
}
