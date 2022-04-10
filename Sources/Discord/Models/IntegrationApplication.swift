// 
// 

import Foundation

public extension Integration {
  /// - seealso: https://discord.com/developers/docs/resources/guild#integration-application-object-integration-application-structure
  struct Application: Decodable {
    /// The id of the app
    public let id: Snowflake
    /// The name of the app
    public let name: String
    /// The icon hash of the app
    public let icon: String?
    /// The description of the app
    public let description: String
    /// The bot associated with this application
    public let bot: User?
  }
}
