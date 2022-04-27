// 
// 

import Foundation

public protocol PartialCodable {
  associatedtype CodingKeys: CodingKey, Hashable
  
  static func partialMapper(for key: CodingKeys) -> PartialMapper<Self>
}

public struct PartialMapper<T> where T: PartialCodable {
  let keyPath: String
  let valueType: Any.Type
  let decoder: PartialDecoder?
  let encoder: PartialEncoder?
  
  public static func keyPath<Value>(_ keyPath: KeyPath<T, Value>) -> Self where Value: Decodable {
    self.init(keyPath: keyPath,
              decoder: AnyPartialDecoder<Value>(),
              encoder: nil)
  }
  
  public static func keyPath<Value>(_ keyPath: KeyPath<T, Value>) -> Self where Value: Encodable {
    self.init(keyPath: keyPath,
              decoder: nil,
              encoder: AnyPartialEncoder<Value>())
  }
  
  public static func keyPath<Value>(_ keyPath: KeyPath<T, Value>) -> Self where Value: Codable {
    self.init(keyPath: keyPath,
              decoder: AnyPartialDecoder<Value>(),
              encoder: AnyPartialEncoder<Value>())
  }
  
  init<Value>(keyPath: KeyPath<T, Value>,
              decoder: PartialDecoder?,
              encoder: PartialEncoder?) {
    self.keyPath = keyPath.stringValue
    self.valueType = Value.self
    self.decoder = decoder
    self.encoder = encoder
  }
  
  func isKeyPathEqual<Value>(to keyPath: KeyPath<T, Value>) -> Bool {
    self.keyPath == keyPath.stringValue && valueType == Value.self
  }
}

protocol PartialDecoder {
  func decode<C, K>(from container: C, for key: K) throws -> Any where C: KeyedDecodingContainerProtocol, C.Key == K
}

struct AnyPartialDecoder<Value>: PartialDecoder where Value: Decodable {
  func decode<C, K>(from container: C, for key: K) throws -> Any where C: KeyedDecodingContainerProtocol, C.Key == K {
    try container.decode(Value.self, forKey: key)
  }
}

protocol PartialEncoder {
  func encode<C, K>(_ value: Any, into container: inout C, for key: K) throws where C: KeyedEncodingContainerProtocol, C.Key == K
}

struct AnyPartialEncoder<Value>: PartialEncoder where Value: Encodable {
  func encode<C, K>(_ value: Any, into container: inout C, for key: K) throws where C: KeyedEncodingContainerProtocol, C.Key == K {
    let value = try (value as? Value).unwrapped()
    try container.encode(value, forKey: key)
  }
}

@dynamicMemberLookup
public struct Partial<T> where T: PartialCodable {
  var values: [T.CodingKeys: (value: Any, mapper: PartialMapper<T>)] = [:]
  
  public subscript<S>(dynamicMember keyPath: KeyPath<T, S>) -> S? {
    guard let value = values.first(where: { $0.value.mapper.isKeyPathEqual(to: keyPath) }) else { return nil }
    return value as? S
  }
}

extension Partial: Decodable where T: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: T.CodingKeys.self)
    values = try container.allKeys.reduce(into: [:]) { (values, key) in
      let mapper = T.partialMapper(for: key)
      values[key] = (try mapper.decoder.unwrapped().decode(from: container, for: key), mapper)
    }
  }
}

extension Partial: Encodable where T: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: T.CodingKeys.self)
    for (key, valueMapper) in values {
      try valueMapper.mapper.encoder.unwrapped().encode(valueMapper.value, into: &container, for: key)
    }
  }
}

private extension KeyPath {
  var stringValue: String {
    NSExpression(forKeyPath: self).keyPath
  }
}
