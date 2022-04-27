// 
// 

import Foundation

/// A protocol that allows an object to be partially decoded/encoded
public protocol PartialCodable {
  associatedtype CodingKeys: CodingKey, Hashable, CaseIterable
  
  static func partialMapper(for key: CodingKeys) -> PartialMapper<Self>
}

/// Represents a binding between a CodingKey and a KeyPath
public struct PartialMapper<T> where T: PartialCodable {
  let keyPath: Any
  let decoder: PartialDecoder?
  let encoder: PartialEncoder?
  let valueFrom: (T) -> Any
  
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
    self.keyPath = keyPath
    self.decoder = decoder
    self.encoder = encoder
    self.valueFrom = { $0[keyPath: keyPath] }
  }
  
  func isKeyPathEqual<Value>(to keyPath: KeyPath<T, Value>) -> Bool {
    self.keyPath as? KeyPath<T, Value> == keyPath
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
  private var keyValues: [T.CodingKeys: Any] = [:]
  
  public init() { }
  
  public init(_ object: T) {
    keyValues = T.CodingKeys.allCases.reduce(into: [:]) { keyValues, key in
      keyValues[key] = T.partialMapper(for: key).valueFrom(object)
    }
  }
  
  public subscript<S>(dynamicMember keyPath: KeyPath<T, S>) -> S? {
    get {
      guard let value = keyValues.first(where: { T.partialMapper(for: $0.key).isKeyPathEqual(to: keyPath) })?.value else { return nil }
      return value as? S
    } set {
      guard let key = T.CodingKeys.allCases.first(where: { T.partialMapper(for: $0).isKeyPathEqual(to: keyPath) }) else { return }
      keyValues[key] = newValue
    }
  }
}

extension Partial: Decodable where T: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: T.CodingKeys.self)
    keyValues = try container.allKeys.reduce(into: [:]) { (values, key) in
      let decoder = try T.partialMapper(for: key).decoder.unwrapped()
      values[key] = try decoder.decode(from: container, for: key)
    }
  }
}

extension Partial: Encodable where T: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: T.CodingKeys.self)
    for (key, value) in keyValues {
      let mapper = T.partialMapper(for: key)
      try mapper.encoder.unwrapped().encode(value, into: &container, for: key)
    }
  }
}

extension Partial: CustomReflectable {
  public var customMirror: Mirror {
    let children = keyValues.map { keyValue -> (String, Any) in
      (keyValue.key.stringValue, keyValue.value)
    }.sorted(by: { $0.0 < $1.0 })
    return Mirror(self, children: children, displayStyle: .struct)
  }
}
