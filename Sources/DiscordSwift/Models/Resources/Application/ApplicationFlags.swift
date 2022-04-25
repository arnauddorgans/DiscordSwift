// 
// 

import Foundation

public extension Application {
  /// - seealso: https://discord.com/developers/docs/resources/application#application-object-application-flags
  struct Flags: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    
    /// Intent required for bots in 100 or more servers to receive presence_update events
    public static let gatewayPresence: Flags = .init(rawValue: 1 << 12)
    /// Intent required for bots in under 100 servers to receive presence_update events, found in Bot Settings
    public static let gatewayPresenceLimited: Flags = .init(rawValue: 1 << 13)
    /// Intent required for bots in 100 or more servers to receive member-related events like guild_member_add. See list of member-related events under GUILD_MEMBERS
    public static let gatewayGuildMembers: Flags = .init(rawValue: 1 << 14)
    /// Intent required for bots in under 100 servers to receive member-related events like guild_member_add, found in Bot Settings. See list of member-related events under GUILD_MEMBERS
    public static let gatewayGuildMembersLimited: Flags = .init(rawValue: 1 << 15)
    /// Indicates unusual growth of an app that prevents verification
    public static let verificationPendingGuildLimit: Flags = .init(rawValue: 1 << 16)
    /// Indicates if an app is embedded within the Discord client (currently unavailable publicly)
    public static let embedded: Flags = .init(rawValue: 1 << 17)
    /// Intent required for bots in 100 or more servers to receive message content
    public static let gatewayMessageContent: Flags = .init(rawValue: 1 << 18)
    /// Intent required for bots in under 100 servers to receive message content, found in Bot Settings
    public static let gatewayMessageContentLimited: Flags = .init(rawValue: 1 << 19)
  }
}

// MARK: Decodable
extension Application.Flags: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(Int.self)
    self.init(rawValue: rawValue)
  }
}

// MARK: Encodable
extension Application.Flags: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
