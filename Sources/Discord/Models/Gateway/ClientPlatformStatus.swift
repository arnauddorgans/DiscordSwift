// 
// 

import Foundation

/// Active sessions are indicated with an "online", "idle", or "dnd" string per platform. If a user is offline or invisible, the corresponding field is not present.
/// - seealso: https://discord.com/developers/docs/topics/gateway#client-status-object
public struct ClientPlatformStatus: Decodable {
  /// The user's status set for an active desktop (Windows, Linux, Mac) application session
  public let desktop: ClientStatus?
  /// The user's status set for an active mobile (iOS, Android) application session
  public let mobile: ClientStatus?
  /// The user's status set for an active web (browser, bot account) application session
  public let web: ClientStatus?
}
