// 
// 

import Foundation

enum BodyEncoder {
  case json
  case urlEncodedForm
  
  static let `default`: BodyEncoder = .json
}
