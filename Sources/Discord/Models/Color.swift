// 
// 

import Foundation

public struct Color {
  /// Integer representation of hexadecimal color code
  public let code: Int
}

// MARK: Decodable
extension Color: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let code = try container.decode(Int.self)
    self.init(code: code)
  }
}
