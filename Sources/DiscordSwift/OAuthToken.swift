// 
// 

import Foundation

public struct OAuthToken: Codable {
  public let accessToken: String
  public let tokenType: String
  public let expiresIn: TimeInterval
  public let refreshToken: String
  public let scope: String
}

extension OAuthToken {
  enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case tokenType = "token_type"
    case expiresIn = "expires_in"
    case refreshToken = "refresh_token"
    case scope
  }
}
