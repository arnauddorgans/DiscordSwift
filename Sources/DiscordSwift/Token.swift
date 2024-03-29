// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/reference#authentication
public enum Token {
  /// Using a bot token gained by registering a bot
  case botToken(String)
  /// Using an OAuth2 bearer token gained through the OAuth2 API
  case oauthToken(OAuthToken)
}

extension Token {
  var stringValue: String {
    switch self {
    case let .botToken(stringValue):
      return stringValue
    case let .oauthToken(token):
      return token.accessToken
    }
  }
}
