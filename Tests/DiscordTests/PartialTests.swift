// 
// 

import XCTest
@testable import DiscordSwift

final class PartialTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testDecode() throws {
    let data = """
{
  "fake_name": "Rammus"
}
"""
    let partialObject = try JSONDecoder().decode(Partial<FakeObject>.self, from: Data(data.utf8))
    XCTAssertNil(partialObject.id)
    XCTAssertEqual(partialObject.name, "Rammus")
    dump(partialObject)
  }
  
  func testEncode() throws {
    var partialObject: Partial<FakeObject> = .init()
    partialObject.name = "Rammus"
    let data = try JSONEncoder().encode(partialObject)
    let json = try JSONSerialization.jsonObject(with: data)
    let dictionary = try (json as? [String: Any]).unwrapped()
    XCTAssertNil(dictionary["id"])
    XCTAssertEqual(dictionary["fake_name"] as? String, "Rammus")
  }
  
  func testInitFormObject() {
    let object = FakeObject(id: .init(), name: "Rammus")
    let partialObject: Partial<FakeObject> = .init(object)
    XCTAssertEqual(partialObject.id, object.id)
    XCTAssertEqual(partialObject.name, object.name)
  }
}

private struct FakeObject: Codable {
  let id: UUID
  let name: String
}

extension FakeObject: PartialCodable {
  static func partialMapper(for key: CodingKeys) -> PartialMapper<FakeObject> {
    switch key {
    case .id:   return .keyPath(\.id)
    case .name: return .keyPath(\.name)
    }
  }
  
  enum CodingKeys: String, CodingKey, CaseIterable {
    case id
    case name = "fake_name"
  }
}
