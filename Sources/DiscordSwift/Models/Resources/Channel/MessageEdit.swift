// 
// 

import Foundation

public extension Message {
  /// - seealso: https://discord.com/developers/docs/resources/webhook#edit-webhook-message-jsonform-params
  struct Edit: Codable {
    /// The message contents (up to 2000 characters)
    public let content: String?
    /// Embedded rich content
    public let embeds: [Embed]?
    /// Allowed mentions for the message
    public let allowedMentions: AllowedMentions?
    /// The components to include with the message
    public let components: [Component]?
    /// The contents of the file being sent/edited
    //public let files
    /// JSON encoded body of non-file params (multipart/form-data only)
    //public let payloadJSON:
    /// Attached files to keep and possible descriptions for new files
    public let attachments: [Attachment]?
    
    public init(content: String? = nil,
                embeds: [Embed]? = nil,
                allowedMentions: AllowedMentions? = nil,
                components: [Component]? = nil,
                attachments: [Attachment]? = nil) {
      self.content = content
      self.embeds = embeds
      self.allowedMentions = allowedMentions
      self.components = components
      self.attachments = attachments
    }
  }
}
