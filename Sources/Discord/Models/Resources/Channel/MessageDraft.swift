// 
// 

import Foundation

public extension Message {
  /// - seealso: https://discord.com/developers/docs/resources/channel#create-message-jsonform-params
  struct Draft: Codable {
    /// The message contents (up to 2000 characters)
    public let content: String?
    /// True if this is a TTS message
    public let tts: Bool?
    /// Embedded rich content (up to 6000 characters)
    public let embeds: [Embed]?
    /// Allowed mentions for the message
    public let allowedMentions: AllowedMention?
    /// Include to make your message a reply
    public let messageReference: Snowflake?
    /// The components to include with the message
    public let components: [Component]?
    /// IDs of up to 3 stickers in the server to send in the message
    public let stickerIDs: [Snowflake]?
    /// The contents of the file being sent
    //public let files
    /// JSON encoded body of non-file params
    //public let payloadJSON:
    /// Attachment objects with filename and description
    public let attachments: [Attachment]?
    /// Message flags combined as a bitfield (only SUPPRESS_EMBEDS can be set)
    public let flags: Flags?
    
    public init(content: String? = nil,
                tts: Bool? = nil,
                embeds: [Embed]? = nil,
                allowedMentions: AllowedMention? = nil,
                messageReference: Snowflake? = nil,
                components: [Component]? = nil,
                stickerIDs: [Snowflake]? = nil,
                attachments: [Attachment]? = nil,
                flags: Message.Flags? = nil) {
      self.content = content
      self.tts = tts
      self.embeds = embeds
      self.allowedMentions = allowedMentions
      self.messageReference = messageReference
      self.components = components
      self.stickerIDs = stickerIDs
      self.attachments = attachments
      self.flags = flags
    }
  }
}


extension Message.Draft {
  enum CodingKeys: String, CodingKey {
    case content
    case tts
    case embeds
    case allowedMentions = "allowed_mentions"
    case messageReference = "message_reference"
    case components
    case stickerIDs = "sticker_ids"
    //case files
    //case payloadJSON = "payload_json"
    case attachments
    case flags
  }
}
