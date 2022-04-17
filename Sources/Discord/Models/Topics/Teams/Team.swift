// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/teams#data-models-team-object
public struct Team: Decodable {
  /// A hash of the image of the team's icon
  public let icon: String?
  /// The unique id of the team
  public let id: Snowflake
  /// The members of the team
  public let members: [Member]
  /// The name of the team
  public let name: String
  /// The user id of the current team owner
  public let ownerUserID: Snowflake
}

extension Team {
  enum CodingKeys: String, CodingKey {
    case icon
    case id
    case members
    case name
    case ownerUserID = "owner_user_id"
  }
}
