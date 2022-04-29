// 
// 

import Foundation

public extension Interaction {
  /// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object
  struct Response: Encodable {
    /// The type of response
    public let type: CallbackType
    /// An optional response message
    public let data: CallbackData?
    
    public init(type: CallbackType,
                data: CallbackData? = nil) {
      self.type = type
      self.data = data
    }
  }
}
