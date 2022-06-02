// 
// 

import Foundation

@propertyWrapper
public struct SafeArrayCodable<T> {
  public var wrappedValue: [T]
  
  public init(wrappedValue: [T]) {
    self.wrappedValue = wrappedValue
  }
}

// MARK: Decodable
extension SafeArrayCodable: Decodable where T: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let elements = try container.decode([SafeCodable<T>].self)
    self.init(wrappedValue: elements.compactMap(\.wrappedValue))
  }
}

// MARK: Encodable
extension SafeArrayCodable: Encodable where T: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    let elements = wrappedValue.map { SafeCodable(wrappedValue: $0) }
    try container.encode(elements)
  }
}
