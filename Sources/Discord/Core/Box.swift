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
