// 
// 

import Foundation

public extension Interaction {
  /// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-autocomplete
  struct CallbackAutocomplete: Codable {
    /// Autocomplete choices (max of 25 choices)
    public let choices: [ApplicationCommand.Option.Choice]
    
    public init(choices: [ApplicationCommand.Option.Choice]) {
      self.choices = choices
    }
  }
}
