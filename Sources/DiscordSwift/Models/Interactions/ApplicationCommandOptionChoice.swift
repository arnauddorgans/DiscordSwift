// 
// 

import Foundation

public extension ApplicationCommand.Option {
  /// - seealso: https://discord.com/developers/docs/interactions/application-commands#application-command-object-application-command-option-choice-structure
  struct Choice: Codable {
    /// 1-100 character choice name
    public let name: String
    /// Localization dictionary for the name field. Values follow the same restrictions as name
    public let nameLocalizations: [String: String]?
    /// Value for the choice, up to 100 characters if string
    public let value: InputValue
    
    public init(name: String,
                nameLocalizations: [String: String]? = nil,
                value: InputValue) {
      self.name = name
      self.nameLocalizations = nameLocalizations
      self.value = value
    }
  }
}

extension ApplicationCommand.Option.Choice {
  enum CodingKeys: String, CodingKey {
    case name
    case nameLocalizations = "name_localizations"
    case value
  }
}
