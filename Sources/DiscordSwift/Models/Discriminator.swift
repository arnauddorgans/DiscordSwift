// 
// 

import Foundation

public struct Discriminator {
  public let intValue: Int
  public let stringValue: String
}

// MARK: Decodable
extension Discriminator: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)
    guard let intValue = Int(stringValue) else {
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Not an Int"))
    }
    self.init(intValue: intValue, stringValue: stringValue)
  }
}

// MARK: Encodable
extension Discriminator: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(intValue)
  }
}
