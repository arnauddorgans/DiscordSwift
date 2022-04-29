// 
// 

import Foundation

public extension ApplicationCommand {
  enum OptionType: Int, Codable {
    /// SUB_COMMAND
    case subCommand = 1
    /// SUB_COMMAND_GROUP
    case subCommandGroup = 2
    /// STRING
    case string = 3
    /// INTEGER
    /// - note: Any integer between -2^53 and 2^53
    case integer = 4
    /// BOOLEAN
    case boolean = 5
    /// USER
    case user = 6
    /// CHANNEL
    /// - note: Includes all channel types + categories
    case channel = 7
    /// ROLE
    case role = 8
    /// MENTIONABLE
    /// - note: Includes users and roles
    case mentionable = 9
    /// NUMBER
    /// - note: Any double between -2^53 and 2^53
    case number = 10
    /// ATTACHMENT
    /// - note: Attachment object
    case attachment = 11
  }
}
