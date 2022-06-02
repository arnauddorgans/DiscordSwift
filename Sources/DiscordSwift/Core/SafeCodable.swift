// 
// 

import Foundation

@propertyWrapper
public struct SafeCodable<T> {
  public var wrappedValue: T?
  
  public init(wrappedValue: T?) {
    self.wrappedValue = wrappedValue
  }
}

// MARK: Decodable
extension SafeCodable: Decodable where T: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    wrappedValue = try? container.decode(T.self)
  }
}

// MARK: Encodable
extension SafeCodable: Encodable where T: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    do {
      try container.encode(wrappedValue)
    } catch {
      try container.encodeNil()
    }
  }
}
