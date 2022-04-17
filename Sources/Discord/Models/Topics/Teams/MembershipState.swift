// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/teams#data-models-membership-state-enum
public enum MembershipState: Int, Decodable {
  case invited = 1
  case accepted = 2
}
