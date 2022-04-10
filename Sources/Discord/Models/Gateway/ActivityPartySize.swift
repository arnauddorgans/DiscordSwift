// 
// 

import Foundation

public extension Activity.Party {
  struct Size {
    public let currentSize: Int
    public let maxSize: Int
  }
}

// MARK: Decodable
extension Activity.Party.Size: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let sizes = try container.decode([Int].self)
    guard sizes.count == 2 else {
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Invalid array size"))
    }
    self.init(currentSize: sizes[0],
              maxSize: sizes[1])
  }
}
