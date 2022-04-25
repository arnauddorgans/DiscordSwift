// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/reference#error-messages
struct ErrorMessage: Error, Decodable {
  let code: Int
  let message: String
}
