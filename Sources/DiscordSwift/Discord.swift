// 
// 

import Foundation

public final class Discord {
  private let authenticationService: AuthenticationService
  private let userService: UserService
  private let guildService: GuildService
  private let channelService: ChannelService
  private let imageURLService: ImageURLService
  private let gatewayService: GatewayService
  
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
  private static var _shared: Discord?

  /// The shared discord instance.
  static var shared: Discord {
    if let discord = _shared { return discord }
    _shared = .init()
    return _shared!
  }
  
  var auth: AuthenticationService { authenticationService }
  var user: UserService { userService }
  var guild: GuildService { guildService }
  var channel: ChannelService { channelService }
  var imageURL: ImageURLService { imageURLService }
  var gateway: GatewayService { gatewayService }
  
  /// Create new Discord instance
  convenience init() {
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
    self.init(authenticationService: authenticationService,
              userService: userService,
              guildService: guildService,
              channelService: channelService,
              imageURLService: imageURLService,
              gatewayService: gatewayService)
  }
}
