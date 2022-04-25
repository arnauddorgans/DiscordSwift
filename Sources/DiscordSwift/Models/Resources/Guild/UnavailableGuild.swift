// 
// 

import Foundation

/// A partial guild object. Represents an Offline Guild, or a Guild whose information has not been provided through Guild Create events during the Gateway connect.
/// - seealso: https://discord.com/developers/docs/resources/guild#unavailable-guild-object-example-unavailable-guild
struct UnavailableGuild: Codable {
  let id: String
  let unavailable: Bool
}
