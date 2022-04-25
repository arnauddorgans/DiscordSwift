// 
// 

import Foundation

/// - note: Codable from milliseconds to date
public struct UnixTimestamp {
  public let date: Date
}

// MARK: Decodable
extension UnixTimestamp: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let timestamp = try container.decode(TimeInterval.self)
    self.init(date: Date(timeIntervalSince1970: timestamp / 1000))
  }
}

// MARK: Encodable
extension UnixTimestamp: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(date.timeIntervalSince1970 * 1000)
  }
}
