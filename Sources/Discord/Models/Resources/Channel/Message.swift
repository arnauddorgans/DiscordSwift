// 
// 

import Foundation

/// Represents a message sent in a channel within Discord.
/// - seealso: https://discord.com/developers/docs/resources/channel#message-object-message-structure
public struct Message: Codable {
  /// ID of the message
  public let id: Snowflake
  /// ID of the channel the message was sent in
  public let channelID: Snowflake
  /// ID of the guild the message was sent in
  public let guildID: Snowflake?
  /// The author of this message (not guaranteed to be a valid user, see below)
  public let author: User
  /// Member properties for this message's author
  public let member: Guild.Member?
  /// Contents of the message
  public let content: String
  /// When this message was sent
  public let timestamp: Date
  /// When this message was edited (or null if never)
  public let editedTimestamp: Date?
  /// Whether this was a TTS message
  public let tts: Bool
  /// Whether this message mentions everyone
  public let mentionEveryone: Bool
  /// Users specifically mentioned in the message
  public let mentions: [User]
  /// Roles specifically mentioned in this message
  public let mentionRoles: [Role]
  /// Channels specifically mentioned in this message
  public let mentionChannels: [Channel.Mention]?
  /// Any attached files
  public let attachments: [Attachment]
  /// Any embedded content
  public let embeds: [Embed]
  /// Reactions to the message
  public let reactions: [Reaction]?
  /// Used for validating a message was sent
  public let nonce: Nonce?
  /// Whether this message is pinned
  public let pinned: Bool
  /// If the message is generated by a webhook, this is the webhook's id
  public let webhookID: Snowflake?
  /// Type of message
  public let type: MessageType
  /// Sent with Rich Presence-related chat embeds
  public let activity: Activity?
  /// Sent with Rich Presence-related chat embeds
  public let application: Application?
  /// If the message is an Interaction or application-owned webhook, this is the id of the application
  public let applicationID: Snowflake?
  /// Data showing the source of a crosspost, channel follow add, pin, or reply message
  public let messageReference: Reference?
  /// Message flags combined as a bitfield
  public let flags: Flags?
  /// Internal wrapper to avoid recursion
  private let referencedMessageBox: Box<Message>?
  /// Sent if the message is a response to an Interaction
  public let interaction: MessageInteraction?
  ///The thread that was started from this message, includes thread member object
  public let thread: Channel?
  /// Sent if the message contains components like buttons, action rows, or other interactive components
  public let components: [Component]?
  /// Sent if the message contains stickers
  public let stickerItems: [Sticker.Item]?
  /// Deprecated the stickers sent with the message
  public let stickers: [Sticker]?
  
  /// The message associated with the message_reference
  public var referencedMessage: Message? {
    referencedMessageBox?.value
  }
}

extension Message {
  enum CodingKeys: String, CodingKey {
    case id
    case channelID = "channel_id"
    case guildID = "guild_id"
    case author
    case member
    case content
    case timestamp
    case editedTimestamp = "edited_timestamp"
    case tts
    case mentionEveryone = "mention_everyone"
    case mentions
    case mentionRoles = "mention_roles"
    case mentionChannels = "mention_channels"
    case attachments
    case embeds
    case reactions
    case nonce
    case pinned
    case webhookID = "webhook_id"
    case type
    case activity
    case application
    case applicationID = "application_id"
    case messageReference = "message_reference"
    case flags
    case referencedMessageBox = "referenced_message"
    case interaction
    case thread
    case components
    case stickerItems = "sticker_items"
    case stickers
  }
}
