// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/reference#snowflakes
public struct Snowflake: Hashable {
  public let stringValue: String
  
  public init(stringValue: String) {
    self.stringValue = stringValue
  }
}

// MARK: Decodable
extension Snowflake: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)
    self.init(stringValue: stringValue)
  }
}

// MARK: Encodable
extension Snowflake: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(stringValue)
  }
}
