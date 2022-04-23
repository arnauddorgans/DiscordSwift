// 
// 

import Foundation

public final class Discord {
  private let authenticationService: AuthenticationService
  public let userService: UserService
  public let guildService: GuildService
  public let channelService: ChannelService
  public let imageURLService: ImageURLService
  public let gatewayService: GatewayService
  
  init(authenticationService: AuthenticationService,
       userService: UserService,
       guildService: GuildService,
       channelService: ChannelService,
       imageURLService: ImageURLService,
       gatewayService: GatewayService) {
    self.userService = userService
    self.authenticationService = authenticationService
    self.guildService = guildService
    self.channelService = channelService
    self.imageURLService = imageURLService
    self.gatewayService = gatewayService
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
    let channelService = ChannelServiceImpl(networkingService: networkingService)
    let imageURLService = ImageURLServiceImpl(environmentService: environmentService)
    #if canImport(WebSocketKit)
    let webSocketService = WebSocketServiceImpl()
    #else
    let webSocketService = WebSocketServiceImpl()
    #endif
    let gatewayService = GatewayServiceImpl(environmentService: environmentService,
                                            authService: authenticationService,
                                            networkingService: networkingService,
                                            webSocketService: webSocketService)
    return .init(authenticationService: authenticationService,
                 userService: userService,
                 guildService: guildService,
                 channelService: channelService,
                 imageURLService: imageURLService,
                 gatewayService: gatewayService)
  }()
  
  // MARK: - Authentication
  func setAuthentication(_ authentication: Authentication?) {
    authenticationService.setAuthentication(authentication)
  }
}
