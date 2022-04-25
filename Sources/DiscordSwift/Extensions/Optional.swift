// 
// 

import Foundation

struct OptionalError: Error { }

protocol OptionalProtocol {
  associatedtype Wrapped
  
  func unwrapped() throws -> Wrapped
}

extension Optional: OptionalProtocol {
  func unwrapped() throws -> Wrapped {
    switch self {
    case .none:
      throw OptionalError()
    case let .some(value):
      return value
    }
  }
}
