// 
// 

import Foundation

public extension ApplicationCommand {
  /// - seealso: https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-structure
  struct Option: Codable {
    /// Type of option
    public let type: OptionType
    /// 1-32 character name
    public let name: String
    /// Localization dictionary for the name field. Values follow the same restrictions as name
    public let nameLocalizations: [String: String]?
    /// 1-100 character description
    public let description: String
    /// Localization dictionary for the description field. Values follow the same restrictions as description
    public let descriptionLocalizations: [String: String]?
    /// If the parameter is required or optional--default false
    public let required: Bool?
    /// Choices for STRING, INTEGER, and NUMBER types for the user to pick from, max 25
    public let choices: [Choice]?
    /// If the option is a subcommand or subcommand group type, these nested options will be the parameters
    public let options: [Option]?
    /// If the option is a channel type, the channels shown will be restricted to these types
    public let channel_types: [ChannelType]?
    /// If the option is an INTEGER or NUMBER type, the minimum value permitted
    public let minValue: Double?
    /// If the option is an INTEGER or NUMBER type, the maximum value permitted
    public let maxValue: Double?
    /// If autocomplete interactions are enabled for this STRING, INTEGER, or NUMBER type option
    public let autocomplete: Bool?
  }
}

extension ApplicationCommand.Option {
  enum CodingKeys: String, CodingKey {
    case type
    case name
    case nameLocalizations = "name_localizations"
    case description
    case descriptionLocalizations = "description_localizations"
    case required
    case choices
    case options
    case channel_types = "channel_types"
    case minValue = "min_value"
    case maxValue = "max_value"
    case autocomplete
  }
}
