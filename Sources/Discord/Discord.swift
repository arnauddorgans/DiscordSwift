// 
// 

import Foundation

public final class Discord {
  private let authenticationService: AuthenticationService
  private let userService: UserService
  private let guildService: GuildService
  
  init(authenticationService: AuthenticationService, userService: UserService, guildService: GuildService) {
    self.userService = userService
    self.authenticationService = authenticationService
    self.guildService = guildService
  }
}

// MARK: Public
public extension Discord {
  /// The shared discord instance.
  static let shared: Discord = {
    let environmentService = EnvironmentServiceImpl()
    let authenticationService = AuthenticationServiceImpl()
    let networkingService = NetworkingServiceImpl(environmentService: environmentService,
                                                  authenticationService: authenticationService)
    let userService = UserServiceImpl(networkingService: networkingService)
    let guildService = GuildServiceImpl(networkingService: networkingService)
    return .init(authenticationService: authenticationService,
                 userService: userService,
                 guildService: guildService)
  }()
  
  // MARK: - Authentication
  func setAuthentication(_ authentication: Authentication?) {
    authenticationService.setAuthentication(authentication)
  }
  
  // MARK: - Users Resource
  /// Returns the user object of the requester's account.
  /// For OAuth2, this requires the identify scope, which will return the object without an email,
  /// and optionally the email scope, which returns the object with an email.
  /// - seealso: https://discord.com/developers/docs/resources/user#get-current-user
  func getCurrentUser() async throws -> User {
    try await userService.getCurrentUser()
  }
  
  /// Returns a user object for a given user ID.
  /// - seealso: https://discord.com/developers/docs/resources/user#get-user
  func getUser(id: String) async throws -> User {
    try await userService.getUser(id: id)
  }
  
  /// Returns a list of connection objects. Requires the connections OAuth2 scope.
  /// - seealso: https://discord.com/developers/docs/resources/user#get-user-connections
  func getUserConnections() async throws -> [Connection] {
    try await userService.getUserConnections()
  }
  
  /// Returns a list of partial guild objects the current user is a member of. Requires the guilds OAuth2 scope.
  /// - seealso: https://discord.com/developers/docs/resources/user#get-current-user-guilds
  func getCurrentUserGuilds() async throws -> [PartialGuild] {
    try await userService.getCurrentUserGuilds()
  }
  
  // MARK: - Guild Resource
  /// Returns the guild object for the given id. If with_counts is set to true, this endpoint will also return approximate_member_count and approximate_presence_count for the guild.
  func getGuild(id: Snowflake) async throws -> Guild {
    try await guildService.guild(id: id)
  }
}
