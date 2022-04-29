// 
// 

import Foundation

public enum InputValue {
  case string(String)
  case number(Double)
}

// MARK: Decodable
extension InputValue: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let string = try? container.decode(String.self) {
      self = .string(string)
    } else {
      self = .number(try container.decode(Double.self))
    }
  }
}

// MARK: Encodable
extension InputValue: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case let .string(string):
      try container.encode(string)
    case let .number(double):
      try container.encode(double)
    }
  }
}
