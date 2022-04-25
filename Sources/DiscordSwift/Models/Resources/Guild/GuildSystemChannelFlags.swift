// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild#guild-object-system-channel-flags
  struct SystemChannelFlags: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
  }
}

public extension Guild.SystemChannelFlags {
  /// Suppress member join notifications
  static let suppressJoinNotifications: Self = .init(rawValue: 1 << 0)
  /// Suppress server boost notifications
  static let suppressPremiumSubscriptions: Self = .init(rawValue: 1 << 1)
  /// Suppress server setup tips
  static let suppressGuildReminderNotifications: Self = .init(rawValue: 1 << 2)
  /// Hide member join sticker reply buttons
  static let suppressJoinNotificationReplies: Self = .init(rawValue: 1 << 3)
}

// MARK: Decodable
extension Guild.SystemChannelFlags: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(Int.self)
    self.init(rawValue: rawValue)
  }
}

// MARK: Encodable
extension Guild.SystemChannelFlags: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
