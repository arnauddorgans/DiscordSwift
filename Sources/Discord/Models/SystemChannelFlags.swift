// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/guild#guild-object-system-channel-flags
public struct SystemChannelFlags: OptionSet {
  public let rawValue: Int
  
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  /// Suppress member join notifications
  public static let suppressJoinNotifications: SystemChannelFlags = .init(rawValue: 1 << 0)
  /// Suppress server boost notifications
  public static let suppressPremiumSubscriptions: SystemChannelFlags = .init(rawValue: 1 << 1)
  /// Suppress server setup tips
  public static let suppressGuildReminderNotifications: SystemChannelFlags = .init(rawValue: 1 << 2)
  /// Hide member join sticker reply buttons
  public static let suppressJoinNotificationReplies: SystemChannelFlags = .init(rawValue: 1 << 3)
}

// MARK: Decodable
extension SystemChannelFlags: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(Int.self)
    self.init(rawValue: rawValue)
  }
}

// MARK: Encodable
extension SystemChannelFlags: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
