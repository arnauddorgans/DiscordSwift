// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/user#user-object-user-flags
public struct UserFlags: OptionSet {
  public let rawValue: Int

  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  /// None
  public static let none: UserFlags = []
  /// Discord Employee
  public static let staff: UserFlags = .init(rawValue: 1 << 0)
  /// Partnered Server Owner
  public static let partner: UserFlags = .init(rawValue: 1 << 1)
  /// HypeSquad Events Member
  public static let hypeSquad: UserFlags = .init(rawValue: 1 << 2)
  /// Bug Hunter Level 1
  public static let bugHunterLevel1: UserFlags = .init(rawValue: 1 << 3)
  /// House Bravery Member
  public static let hypeSquadOnlineHouse1: UserFlags = .init(rawValue: 1 << 6)
  /// House Brilliance Member
  public static let hypeSquadOnlineHouse2: UserFlags = .init(rawValue: 1 << 7)
  /// House Balance Member
  public static let hypeSquadOnlineHouse3: UserFlags = .init(rawValue: 1 << 8)
  /// Early Nitro Supporter
  public static let premiumEarlySupporter: UserFlags = .init(rawValue: 1 << 9)
  /// User is a team
  public static let teamPseudoUser: UserFlags = .init(rawValue: 1 << 10)
  /// Bug Hunter Level 2
  public static let bugHunterLevel2: UserFlags = .init(rawValue: 1 << 14)
  /// Verified Bot
  public static let verifiedBot: UserFlags = .init(rawValue: 1 << 16)
  /// Early Verified Bot Developer
  public static let verifiedDeveloper: UserFlags = .init(rawValue: 1 << 17)
  /// Discord Certified Moderator
  public static let certifiedModerator: UserFlags = .init(rawValue: 1 << 18)
  /// Bot uses only HTTP interactions and is shown in the online member list
  public static let botHTTPInteractions: UserFlags = .init(rawValue: 1 << 19)
}

// MARK: Decodable
extension UserFlags: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(Int.self)
    self.init(rawValue: rawValue)
  }
}

// MARK: Encodable
extension UserFlags: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
