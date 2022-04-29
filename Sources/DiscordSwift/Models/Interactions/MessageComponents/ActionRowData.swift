// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/message-components#action-rows
public struct ActionRowData: Codable {
  public let components: [ComponentData]
  
  public init(components: [ComponentData]) {
    self.components = components
  }
}
