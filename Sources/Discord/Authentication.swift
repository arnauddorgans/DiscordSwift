// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/reference#authentication
public enum Authentication {
  /// Using a bot token gained by registering a bot
  case botToken(String)
  /// Using an OAuth2 bearer token gained through the OAuth2 API
  case token(String)
}
