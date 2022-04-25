// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/channel#thread-member-object-thread-member-structure
public struct ThreadFlags: OptionSet {
  public let rawValue: Int
  
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  public static let notification: ThreadFlags = .init(rawValue: 1 << 1)
}

// MARK: Decodable
extension ThreadFlags: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(Int.self)
    self.init(rawValue: rawValue)
  }
}

// MARK: Encodable
extension ThreadFlags: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(rawValue)
  }
}
