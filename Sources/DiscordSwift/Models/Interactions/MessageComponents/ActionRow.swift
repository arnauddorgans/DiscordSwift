// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/message-components#action-rows
public struct ActionRow: Codable {
  public let components: [Component]
  
  public init(components: [Component]) {
    self.components = components
  }
}
