// 
// 

import Foundation

public final class Discord {
  private let authenticationService: AuthenticationService
  public let userService: UserService
  public let guildService: GuildService
  public let imageURLService: ImageURLService
  
  init(authenticationService: AuthenticationService,
       userService: UserService,
       guildService: GuildService,
       imageURLService: ImageURLService) {
    self.userService = userService
    self.authenticationService = authenticationService
    self.guildService = guildService
    self.imageURLService = imageURLService
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
    let imageURLService = ImageURLServiceImpl(environmentService: environmentService)
    return .init(authenticationService: authenticationService,
                 userService: userService,
                 guildService: guildService,
                 imageURLService: imageURLService)
  }()
  
  // MARK: - Authentication
  func setAuthentication(_ authentication: Authentication?) {
    authenticationService.setAuthentication(authentication)
  }
}
