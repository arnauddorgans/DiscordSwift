// 
// 

import Foundation

public struct Nonce {
  public let stringValue: String
}

// MARK: Decodable
extension Nonce: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    do {
      let stringValue = try container.decode(String.self)
      self.init(stringValue: stringValue)
    } catch {
      let intValue = try container.decode(Int.self)
      self.init(stringValue: String(intValue))
    }
  }
}

// MARK: Encodable
extension Nonce: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(stringValue)
  }
}
