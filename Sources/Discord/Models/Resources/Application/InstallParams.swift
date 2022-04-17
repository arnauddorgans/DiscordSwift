// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/application#install-params-object-install-params-structure
public struct InstallParams: Decodable {
  /// The scopes to add the application to the server with
  public let scopes: [OAuth2Scope]
  /// The permissions to request for the bot role
  public let permissions: Permissions
}
