// 
// 

import Foundation

public extension Component {
  /// - seealso: https://discord.com/developers/docs/interactions/message-components#action-rows
  struct ActionRow: Codable {
    let components: [Component]
    
    public init(components: [Component]) {
      self.components = components
    }
  }
}
