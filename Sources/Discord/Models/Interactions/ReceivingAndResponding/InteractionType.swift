// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-object-interaction-type
public enum InteractionType: Int, Decodable {
  case ping = 1
  case applicationCommand = 2
  case messageComponent = 3
  case applicationCommandAutocomplete = 4
  case modalSubmit = 5
}
