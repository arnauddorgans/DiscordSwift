// 
// 

import Foundation

public protocol ChannelService {
  /// Returns the messages for a channel.
  /// If operating on a guild channel, this endpoint requires the VIEW_CHANNEL permission to be present on the current user.
  /// If the current user is missing the READ_MESSAGE_HISTORY permission in the channel then this will return no messages (since they cannot read the message history). Returns an array of message objects on success.
  /// - seealso: https://discord.com/developers/docs/resources/channel#get-channel-messages
  func getChannelMessages(id: Snowflake, cursor: MessageCursor?, limit: Int?) async throws -> [Message]
  
  /// Post a message to a guild text or DM channel.
  /// Returns a message object.
  /// Fires a Message Create Gateway event. See message formatting for more information on how to properly format messages.
  /// - seealso: https://discord.com/developers/docs/resources/channel#create-message
  @discardableResult
  func createMessage(channelID: Snowflake, draft: Message.Draft) async throws -> Message
  
  func deleteMessage(channelID: Snowflake, messageID: Snowflake) async throws
}

final class ChannelServiceImpl: ChannelService {
  private let networkingService: NetworkingService
  
  init(networkingService: NetworkingService) {
    self.networkingService = networkingService
  }
  
  func getChannelMessages(id: Snowflake, cursor: MessageCursor?, limit: Int?) async throws -> [Message] {
    var queryItems = [URLQueryItem]()
    if let cursor = cursor {
      queryItems.append(.init(name: cursor.rawValue, value: cursor.id.stringValue))
    }
    if let limit = limit {
      queryItems.append(.init(name: "limit", value: String(limit)))
    }
    return try await networkingService.request(method: .get,
                                               path: "/channels/\(id.stringValue)/messages",
                                               queryItems: queryItems)
  }
  
  func createMessage(channelID: Snowflake, draft: Message.Draft) async throws -> Message {
    try await networkingService.request(method: .post,
                                        path: "/channels/\(channelID.stringValue)/messages",
                                        body: draft)
  }
  
  func deleteMessage(channelID: Snowflake, messageID: Snowflake) async throws {
    try await networkingService.request(method: .delete,
                                        path: "/channels/\(channelID.stringValue)/messages/\(messageID.stringValue)")
  }
}
