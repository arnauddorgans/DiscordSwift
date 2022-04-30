// 
// 

import Foundation

public protocol AuthenticationService {
  /// Your application's client id
  var clientID: String? { get }
  /// Your application's client secret
  var clientSecret: String? { get }
  
  var token: Token? { get }
  
  func setClientID(_ clientID: String?, clientSecret: String?)
  
  func setToken(_ token: Token?)
  
  // MARK: Authorization Code Grant
  /// - parameter redirectURI: Whatever URL you registered when creating your application
  /// - parameter state: The unique string mentioned in State and Security
  func authorizationURL(scopes: [OAuth2Scope], redirectURI: String, state: String) throws -> URL
  
  /// - parameter code: The code from the querystring
  /// - parameter redirectURI: The redirect_uri associated with this authorization, usually from your authorization URL
  /// - returns: Exchanged access token
  @discardableResult
  func exchangeAccessToken(code: String, redirectURI: String) async throws -> OAuthToken
}

final class AuthenticationServiceImpl: AuthenticationService {
  private let networkingService: NetworkingService
  private let environmentService: EnvironmentService
  private let authenticationDataService: AuthenticationDataService
  
  init(networkingService: NetworkingService,
       environmentService: EnvironmentService,
       authenticationDataService: AuthenticationDataService) {
    self.networkingService = networkingService
    self.environmentService = environmentService
    self.authenticationDataService = authenticationDataService
  }
  
  func authorizationURL(scopes: [OAuth2Scope], redirectURI: String, state: String) throws -> URL {
    let scopes = scopes.map(\.rawValue).joined(separator: " ")
    let request = try networkingService.urlRequest(method: .get, path: "/oauth2/authorize", queryItems: [
      URLQueryItem(name: "response_type", value: "code"),
      URLQueryItem(name: "client_id", value: clientID),
      URLQueryItem(name: "scope", value: scopes),
      URLQueryItem(name: "state", value: state),
      URLQueryItem(name: "redirect_uri", value: redirectURI)
    ])
    return try request.url.unwrapped(AuthenticationError.invalidURL)
  }
  
  func exchangeAccessToken(code: String, redirectURI: String) async throws -> OAuthToken {
    let clientID = try unwrappedClientID()
    let clientSecret = try unwrappedClientSecret()
    let token: OAuthToken = try await networkingService.request(method: .post, path: "/oauth2/token", bodyEncoder: .urlEncodedForm, body: [
      "client_id": clientID,
      "client_secret": clientSecret,
      "grant_type": "authorization_code",
      "code": code,
      "redirect_uri": redirectURI
    ])
    authenticationDataService.token = .oauthToken(token)
    return token
  }
}

extension AuthenticationServiceImpl {
  var token: Token? { authenticationDataService.token }
  var clientID: String? { authenticationDataService.clientID }
  var clientSecret: String? { authenticationDataService.clientSecret }

  func setToken(_ token: Token?) {
    authenticationDataService.token = token
  }
  
  func setClientID(_ clientID: String?, clientSecret: String?) {
    authenticationDataService.clientID = clientID
    authenticationDataService.clientSecret = clientSecret
  }
}

// MARK: Error
private extension AuthenticationServiceImpl {
  func unwrappedClientID() throws -> String {
    try authenticationDataService.clientID.unwrapped(AuthenticationError.noClientID)
  }
  
  func unwrappedClientSecret() throws -> String {
    try authenticationDataService.clientSecret.unwrapped(AuthenticationError.noClientSecret)
  }
}

private enum AuthenticationError: Error {
  case noClientID
  case noClientSecret
  case invalidURL
}
