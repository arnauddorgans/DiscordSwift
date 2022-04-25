// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/gateway#gateway-intents
public struct GatewayIntents: OptionSet {
  public let rawValue: Int
  
  /// GUILDS
  public static let guilds: Self = .init(rawValue: 1 << 0)
  /// GUILD_MEMBERS
  public static let guildMembers: Self = .init(rawValue: 1 << 1)
  /// GUILD_BANS
  public static let guildBans: Self = .init(rawValue: 1 << 2)
  /// GUILD_EMOJIS_AND_STICKERS
  public static let guildEmojisAndStickers: Self = .init(rawValue: 1 << 3)
  /// GUILD_INTEGRATIONS
  public static let guildIntegrations: Self = .init(rawValue: 1 << 4)
  /// GUILD_WEBHOOKS
  public static let guildWebhooks: Self = .init(rawValue: 1 << 5)
  /// GUILD_INVITES
  public static let guildInvites: Self = .init(rawValue: 1 << 6)
  /// GUILD_VOICE_STATES
  public static let guildVoiceStates: Self = .init(rawValue: 1 << 7)
  /// GUILD_PRESENCES
  public static let guildPresences: Self = .init(rawValue: 1 << 8)
  /// GUILD_MESSAGES
  public static let guildMessages: Self = .init(rawValue: 1 << 9)
  /// GUILD_MESSAGE_REACTIONS
  public static let guildMessageReactions: Self = .init(rawValue: 1 << 10)
  /// GUILD_MESSAGE_TYPING
  public static let guildMessageTyping: Self = .init(rawValue: 1 << 11)
  /// DIRECT_MESSAGES
  public static let directMessages: Self = .init(rawValue: 1 << 12)
  /// DIRECT_MESSAGE_REACTIONS
  public static let directMessageReactions: Self = .init(rawValue: 1 << 13)
  ///  DIRECT_MESSAGE_TYPING
  public static let directMessageTyping: Self = .init(rawValue: 1 << 14)
  /// GUILD_SCHEDULED_EVENTS
  public static let guildScheduledEvents: Self = .init(rawValue: 1 << 16)
  
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
}

// MARK: Decodable
extension GatewayIntents: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(Int.self)
    self.init(rawValue: rawValue)
  }
}

// MARK: Encodable
extension GatewayIntents: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
