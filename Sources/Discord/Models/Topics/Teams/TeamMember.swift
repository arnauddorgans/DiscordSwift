// 
// 

import Foundation

public extension Team {
  /// - seealso: https://discord.com/developers/docs/topics/teams#data-models-team-member-object
  struct Member: Codable {
    /// The user's membership state on the team
    public let membershipState: MembershipState
    /// Will always be ["*"]
    public let permissions: [String]
    /// The id of the parent team of which they are a member
    public let teamID: Snowflake
    /// The avatar, discriminator, id, and username of the user
    public let user: User
  }
}

extension Team.Member {
  enum CodingKeys: String, CodingKey {
    case membershipState = "membership_state"
    case permissions
    case teamID = "team_id"
    case user
  }
}
