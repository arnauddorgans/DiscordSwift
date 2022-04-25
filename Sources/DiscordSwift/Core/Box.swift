// 
// 

import Foundation

final class Box<T> {
  let value: T
  
  init(value: T) {
    self.value = value
  }
}

// MARK: Decodable
extension Box: Decodable where T: Decodable {
  convenience init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let value = try container.decode(T.self)
    self.init(value: value)
  }
}

// MARK: Encodable
extension Box: Encodable where T: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value)
  }
}
