// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/permissions#permissions
public struct Permissions: OptionSet {
  public let rawValue: Int
  
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  /// Allows creation of instant invites
  public static let createInstantInvite: Permissions = .init(rawValue: 1 << 0)
  /// Allows kicking members
  public static let kickMembers: Permissions = .init(rawValue: 1 << 1)
  /// Allows banning members
  public static let banMembers: Permissions = .init(rawValue: 1 << 2)
  /// Allows all permissions and bypasses channel permission overwrites
  public static let administrator: Permissions = .init(rawValue: 1 << 3)
  /// Allows management and editing of channels
  public static let manageChannels: Permissions = .init(rawValue: 1 << 4)
  /// Allows management and editing of the guild
  public static let manageGuild: Permissions = .init(rawValue: 1 << 5)
  /// Allows for the addition of reactions to messages
  public static let addReactions: Permissions = .init(rawValue: 1 << 6)
  /// Allows for viewing of audit logs
  public static let viewAuditLog: Permissions = .init(rawValue: 1 << 7)
  /// Allows for using priority speaker in a voice channel
  public static let prioritySpeaker: Permissions = .init(rawValue: 1 << 8)
  /// Allows the user to go live
  public static let stream: Permissions = .init(rawValue: 1 << 9)
  /// Allows guild members to view a channel, which includes reading messages in text channels and joining voice channels
  public static let viewChannel: Permissions = .init(rawValue: 1 << 10)
  /// Allows for sending messages in a channel and creating threads in a forum (does not allow sending messages in threads)
  public static let sendMessages: Permissions = .init(rawValue: 1 << 11)
  /// Allows for sending of /tts messages
  public static let sendTTSMessages: Permissions = .init(rawValue: 1 << 12)
  /// Allows for deletion of other users messages
  public static let manageMessages: Permissions = .init(rawValue: 1 << 13)
  /// Links sent by users with this permission will be auto-embedded
  public static let embedLinks: Permissions = .init(rawValue: 1 << 14)
  /// Allows for uploading images and files
  public static let attachFiles: Permissions = .init(rawValue: 1 << 15)
  /// Allows for reading of message history
  public static let readMessageHistory: Permissions = .init(rawValue: 1 << 16)
  /// Allows for using the @everyone tag to notify all users in a channel, and the @here tag to notify all online users in a channel
  public static let mentionEveryone: Permissions = .init(rawValue: 1 << 17)
  /// Allows the usage of custom emojis from other servers
  public static let useExternalEmojis: Permissions = .init(rawValue: 1 << 18)
  /// Allows for viewing guild insights
  public static let viewGuildInsights: Permissions = .init(rawValue: 1 << 19)
  /// Allows for joining of a voice channel
  public static let connect: Permissions = .init(rawValue: 1 << 20)
  /// Allows for speaking in a voice channel
  public static let speak: Permissions = .init(rawValue: 1 << 21)
  /// Allows for muting members in a voice channel
  public static let muteMembers: Permissions = .init(rawValue: 1 << 22)
  /// Allows for deafening of members in a voice channel
  public static let deafenMembers: Permissions = .init(rawValue: 1 << 23)
  /// Allows for moving of members between voice channels
  public static let moveMembers: Permissions = .init(rawValue: 1 << 24)
  /// Allows for using voice-activity-detection in a voice channel
  public static let useVAD: Permissions = .init(rawValue: 1 << 25)
  /// Allows for modification of own nickname
  public static let changeNickname: Permissions = .init(rawValue: 1 << 26)
  /// Allows for modification of other users nicknames
  public static let manageNicknames: Permissions = .init(rawValue: 1 << 27)
  /// Allows management and editing of roles
  public static let manageRoles: Permissions = .init(rawValue: 1 << 28)
  /// Allows management and editing of webhooks
  public static let manageWebhooks: Permissions = .init(rawValue: 1 << 29)
  /// Allows management and editing of emojis and stickers
  public static let manageEmojisAndStickers: Permissions = .init(rawValue: 1 << 30)
  /// Allows members to use application commands, including slash commands and context menu commands.
  public static let useApplicationCommands: Permissions = .init(rawValue: 1 << 31)
  /// Allows for requesting to speak in stage channels. (This permission is under active development and may be changed or removed.)
  public static let requestToSpeak: Permissions = .init(rawValue: 1 << 32)
  /// Allows for creating, editing, and deleting scheduled events
  public static let manageEvents: Permissions = .init(rawValue: 1 << 33)
  /// Allows for deleting and archiving threads, and viewing all private threads
  public static let manageThreads: Permissions = .init(rawValue: 1 << 34)
  /// Allows for creating public and announcement threads
  public static let createPublicThreads: Permissions = .init(rawValue: 1 << 35)
  /// Allows for creating private threads
  public static let createPrivateThreads: Permissions = .init(rawValue: 1 << 36)
  /// Allows the usage of custom stickers from other servers
  public static let useExternalStickers: Permissions = .init(rawValue: 1 << 37)
  /// Allows for sending messages in threads
  public static let sendMessagesInThreads: Permissions = .init(rawValue: 1 << 38)
  /// Allows for using Activities (applications with the EMBEDDED flag) in a voice channel
  public static let useEmbeddedActivities: Permissions = .init(rawValue: 1 << 39)
  /// Allows for timing out users to prevent them from sending or reacting to messages in chat and threads, and from speaking in voice and stage channels
  public static let moderateMembers: Permissions = .init(rawValue: 1 << 40)
}

// MARK: Decodable
extension Permissions: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)
    let rawValue = try Int(stringValue).unwrapped(
      DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Invalid permission raw value: \(stringValue)"))
    )
    self.init(rawValue: rawValue)
  }
}

// MARK: Encodable
extension Permissions: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(String(rawValue))
  }
}
