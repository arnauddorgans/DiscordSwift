// 
// 

import Foundation

protocol UserService {
  /// Returns the user object of the requester's account.
  /// For OAuth2, this requires the identify scope, which will return the object without an email,
  /// and optionally the email scope, which returns the object with an email.
  /// - seealso: https://discord.com/developers/docs/resources/user#get-current-user
  func getCurrentUser() async throws -> User
  
  /// Returns a user object for a given user ID.
  /// - seealso: https://discord.com/developers/docs/resources/user#get-user
  func getUser(id: String) async throws -> User
  
  /// Returns a list of connection objects. Requires the connections OAuth2 scope.
  /// - seealso: https://discord.com/developers/docs/resources/user#get-user-connections
  func getUserConnections() async throws -> [Connection]

  /// Returns a list of partial guild objects the current user is a member of. Requires the guilds OAuth2 scope.
  /// - seealso: https://discord.com/developers/docs/resources/user#get-current-user-guilds
  func getCurrentUserGuilds() async throws -> [PartialGuild]
}

final class UserServiceImpl: UserService {
  private let networkingService: NetworkingService
  
  init(networkingService: NetworkingService) {
    self.networkingService = networkingService
  }
  
  func getCurrentUser() async throws -> User {
    try await networkingService.request(method: .get, path: "/users/@me")
  }
  
  func getUser(id: String) async throws -> User {
    try await networkingService.request(method: .get, path: "/users/\(id)")
  }
  
  func getUserConnections() async throws -> [Connection] {
    try await networkingService.request(method: .get, path: "/users/@me/connections")
  }
  
  func getCurrentUserGuilds() async throws -> [PartialGuild] {
    try await networkingService.request(method: .get, path: "/users/@me/guilds")
  }
}
