// 
// 

import Foundation

public extension Activity {
  /// - seealso: https://discord.com/developers/docs/topics/gateway#activity-object-activity-flags
  struct Flags: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    
    public static let instance: Flags = .init(rawValue: 1 << 0)
    public static let join: Flags = .init(rawValue: 1 << 1)
    public static let spectate: Flags = .init(rawValue: 1 << 2)
    public static let joinRequest: Flags = .init(rawValue: 1 << 3)
    public static let sync: Flags = .init(rawValue: 1 << 4)
    public static let play: Flags = .init(rawValue: 1 << 5)
    public static let partyPrivacyFriends: Flags = .init(rawValue: 1 << 6)
    public static let partyPrivacyVoiceChannel: Flags = .init(rawValue: 1 << 7)
    public static let embedded: Flags = .init(rawValue: 1 << 8)
  }
}

// MARK: Decodable
extension Activity.Flags: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(Int.self)
    self.init(rawValue: rawValue)
  }
}

// MARK: Encodable
extension Activity.Flags: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
