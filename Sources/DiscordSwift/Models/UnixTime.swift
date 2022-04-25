// 
// 

import Foundation

/// - note: Codable from milliseconds to seconds
public struct UnixTime {
  public let seconds: TimeInterval
  
  public var milliseconds: TimeInterval { seconds * 1000 }
}

// MARK: Decodable
extension UnixTime: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let timeInterval = try container.decode(TimeInterval.self)
    self.init(seconds: timeInterval / 1000)
  }
}

// MARK: Encodable
extension UnixTime: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(milliseconds)
  }
}
