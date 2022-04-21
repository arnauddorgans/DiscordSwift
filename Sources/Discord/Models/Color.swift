// 
// 

import Foundation

public struct Color {
  /// Integer representation of hexadecimal color code
  public let code: Int
  
  public init(code: Int) {
    self.code = code
  }
}

// MARK: Decodable
extension Color: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let code = try container.decode(Int.self)
    self.init(code: code)
  }
}

// MARK: Encodable
extension Color: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(code)
  }
}
