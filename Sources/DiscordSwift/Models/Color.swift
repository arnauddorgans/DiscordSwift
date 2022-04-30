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

// MARK: Basic colors
public extension Color {
  static let white: Color = .init(code: 0xFFFFFF)
  static let silver: Color = .init(code: 0xC0C0C0)
  static let gray: Color = .init(code: 0x808080)
  static let black: Color = .init(code: 0x000000)
  static let red: Color = .init(code: 0xFF0000)
  static let maroon: Color = .init(code: 0x800000)
  static let yellow: Color = .init(code: 0xFFFF00)
  static let olive: Color = .init(code: 0x808000)
  static let lime: Color = .init(code: 0x00FF00)
  static let green: Color = .init(code: 0x008000)
  static let aqua: Color = .init(code: 0x00FFFF)
  static let teal: Color = .init(code: 0x008080)
  static let blue: Color = .init(code: 0x0000FF)
  static let navy: Color = .init(code: 0x000080)
  static let fuchsia: Color = .init(code: 0xFF00FF)
  static let purple: Color = .init(code: 0x800080)
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
