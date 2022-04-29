// 
// 

import Foundation

public extension Interaction {
  /// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-modal
  struct CallbackModal: Codable {
    /// A developer-defined identifier for the component, max 100 characters
    public let customID: String
    /// The title of the popup modal, max 45 characters
    public let title: String
    /// Between 1 and 5 (inclusive) components that make up the modal
    public let components: [Component]
    
    public init(customID: String,
                title: String,
                components: [Component]) {
      self.customID = customID
      self.title = title
      self.components = components
    }
  }
}

extension Interaction.CallbackModal {
  enum CodingKeys: String, CodingKey {
    case customID = "custom_id"
    case title
    case components
  }
}
