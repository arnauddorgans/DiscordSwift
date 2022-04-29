// 
// 

import Foundation

public extension Interaction {
  /// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-interaction-callback-type
  enum CallbackType: Int, Codable {
    /// ACK a Ping
    case pong = 1
    /// Respond to an interaction with a message
    case channelMessageWithSource = 4
    /// ACK an interaction and edit a response later, the user sees a loading state
    case deferredChannelMessageWithSource = 5
    /// For components, ACK an interaction and edit the original message later; the user does not see a loading state
    case deferredUpdateMessage = 6
    /// For components, edit the message the component was attached to
    case updateMessage = 7
    /// Respond to an autocomplete interaction with suggested choices
    case applicationCommandAutocompleteResult = 8
    /// Respond to an interaction with a popup modal
    case modal = 9
  }
}
