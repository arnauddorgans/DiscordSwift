// 
// 

import Foundation

public extension Integration {
  /// - seealso: https://discord.com/developers/docs/resources/guild#integration-account-object-integration-account-structure
  struct Account: Decodable {
    /// ID of the account
    public let id: String
    /// Name of the account
    public let name: String
  }
}
