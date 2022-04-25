// 
// 

import Foundation

public extension Message {
  /// - seealso: https://discord.com/developers/docs/resources/channel#message-object-message-flags
  struct Flags: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    
    /// This message has been published to subscribed channels (via Channel Following)
    public static let crossposted: Flags = .init(rawValue: 1 << 0)
    /// This message originated from a message in another channel (via Channel Following)
    public static let isCrosspost: Flags = .init(rawValue: 1 << 1)
    /// Do not include any embeds when serializing this message
    public static let suppressEmbeds: Flags = .init(rawValue: 1 << 2)
    /// The source message for this crosspost has been deleted (via Channel Following)
    public static let sourceMessageDeleted: Flags = .init(rawValue: 1 << 3)
    /// This message came from the urgent message system
    public static let urgent: Flags = .init(rawValue: 1 << 4)
    /// This message has an associated thread, with the same id as the message
    public static let hasThread: Flags = .init(rawValue: 1 << 5)
    /// This message is only visible to the user who invoked the Interaction
    public static let ephemeral: Flags = .init(rawValue: 1 << 6)
    /// This message is an Interaction Response and the bot is "thinking"
    public static let loading: Flags = .init(rawValue: 1 << 7)
    /// This message failed to mention some roles and add their members to the thread
    public static let failedToMentionSomeRolesInThread: Flags = .init(rawValue: 1 << 8)
  }
}

// MARK: Decodable
extension Message.Flags: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(Int.self)
    self.init(rawValue: rawValue)
  }
}

// MARK: Encodable
extension Message.Flags: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
