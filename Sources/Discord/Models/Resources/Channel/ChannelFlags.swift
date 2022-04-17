// 
// 

import Foundation

public extension Channel {
  /// - seealso: https://discord.com/developers/docs/resources/channel#channel-object-channel-flags
  struct Flags: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
    
    /// This thread is pinned to the top of its parent forum channel
    public static let pinned: Flags = .init(rawValue: 1 << 1)
  }
}

// MARK: Decodable
extension Channel.Flags: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(Int.self)
    self.init(rawValue: rawValue)
  }
}

// MARK: Encodable
extension Channel.Flags: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
