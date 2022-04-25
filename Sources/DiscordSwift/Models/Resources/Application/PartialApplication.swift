// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/application#application-object-application-structure
public struct PartialApplication: Codable {
  /// The id of the app
  public let id: Snowflake
  /// The application's public flags
  public let flags: Application.Flags?
}
