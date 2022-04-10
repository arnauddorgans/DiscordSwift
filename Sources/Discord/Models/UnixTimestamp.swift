// 
// 

import Foundation

public struct UnixTimestamp {
  public let date: Date
}

extension UnixTimestamp: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let timestamp = try container.decode(TimeInterval.self)
    self.init(date: Date(timeIntervalSince1970: timestamp / 1000))
  }
}
