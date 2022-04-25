// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/channel#allowed-mentions-object-allowed-mention-types
public enum AllowedMentionType: String, Codable {
  /// Controls role mentions
  case roles
  /// Controls user mentions
  case users
  /// Controls @everyone and @here mentions
  case everyone
}

