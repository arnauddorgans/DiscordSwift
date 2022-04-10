// 
// 

import Foundation

public final class Discord {
  private let authenticationService: AuthenticationService
  public let userService: UserService
  public let guildService: GuildService
  
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
}
