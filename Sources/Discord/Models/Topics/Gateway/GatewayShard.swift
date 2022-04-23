// 
// 

import Foundation

struct GatewayShard {
  let id: Int
  let numShards: Int
}

// MARK: Decodable
extension GatewayShard: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let array = try container.decode([Int].self)
    guard array.count == 2 else {
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Invalid array"))
    }
    self.init(id: array[0], numShards: array[1])
  }
}

// MARK: Encodable
extension GatewayShard: Encodable {
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode([id, numShards])
  }
}
