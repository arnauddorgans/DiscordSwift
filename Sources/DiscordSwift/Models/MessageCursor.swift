// 
// 

import Foundation

public enum MessageCursor {
  case around(Snowflake)
  case before(Snowflake)
  case after(Snowflake)
  
  var id: Snowflake {
    switch self {
    case let .around(id),
      let .before(id),
      let .after(id):
      return id
    }
  }
  
  var rawValue: String {
    switch self {
    case .around: return "around"
    case .before: return "before"
    case .after:  return "after"
    }
  }
}
