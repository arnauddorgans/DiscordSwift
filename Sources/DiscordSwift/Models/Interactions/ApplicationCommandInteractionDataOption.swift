// 
// 

import Foundation

public extension ApplicationCommand {
  /// - seealso: https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-interaction-data-option-structure
  struct InteractionDataOption: Codable {
    /// Name of the parameter
    public let name: String
    /// Value of application command option type
    public let type: OptionType
    /// Value of the option resulting from user input
    public let value: InputValue?
    /// Present if this option is a group or subcommand
    public let options: [InteractionDataOption]?
    /// True if this option is the currently focused option for autocomplete
    public let focused: Bool?
  }
}
