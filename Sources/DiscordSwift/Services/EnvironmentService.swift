// 
// 

import Foundation

protocol EnvironmentService {
  var apiBaseURL: String { get }
  var imageBaseURL: String { get }
  var apiVersion: APIVersion { get }
  var gatewayVersion: GatewayVersion { get }
  var libraryName: String { get }
  var userAgent: String { get }
}

final class EnvironmentServiceImpl: EnvironmentService {
  let apiBaseURL: String = "https://discord.com/api"
  let imageBaseURL: String = "https://cdn.discordapp.com"
  let apiVersion: APIVersion = .v9
  let gatewayVersion: GatewayVersion = .v9
  let libraryName: String = "DiscordSwift"
  
  var userAgent: String { libraryName }
}
