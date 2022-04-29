// 
// 

import Foundation

public extension Interaction {
  /// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#interaction-response-object-messages
  struct CallbackMessage: Codable {
    /// Is the response TTS
    public let tts: Bool?
    /// Message content
    public let content: String?
    /// Supports up to 10 embeds
    public let embeds: [Embed]?
    /// Allowed mentions object
    public let allowedMentions: AllowedMentions?
    /// Message flags combined as a bitfield (only SUPPRESS_EMBEDS and EPHEMERAL can be set)
    public let flags: Message.Flags?
    /// Message components
    public let components: [Component]?
    /// Attachment objects with filename and description
    public let attachments: [Attachment]?
    
    public init(tts: Bool? = nil,
                content: String? = nil,
                embeds: [Embed]? = nil,
                allowedMentions: AllowedMentions? = nil,
                flags: Message.Flags? = nil,
                components: [Component]? = nil,
                attachments: [Attachment]? = nil) {
      self.tts = tts
      self.content = content
      self.embeds = embeds
      self.allowedMentions = allowedMentions
      self.flags = flags
      self.components = components
      self.attachments = attachments
    }
  }
}

extension Interaction.CallbackMessage {
  enum CodingKeys: String, CodingKey {
    case tts
    case content
    case embeds
    case allowedMentions = "allowed_mentions"
    case flags
    case components
    case attachments
  }
}
