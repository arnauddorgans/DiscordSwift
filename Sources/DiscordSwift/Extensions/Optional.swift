// 
// 

import Foundation

protocol OptionalProtocol {
  associatedtype Wrapped
  
  func unwrapped(_ error: Error) throws -> Wrapped
}

extension Optional: OptionalProtocol {
  func unwrapped(_ error: Error) throws -> Wrapped {
    switch self {
    case .none:
      throw error
    case let .some(value):
      return value
    }
  }
}
