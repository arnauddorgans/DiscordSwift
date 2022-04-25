// 
// 

import Foundation

public protocol ChannelService {
  /// Returns the messages for a channel.
  /// If operating on a guild channel, this endpoint requires the VIEW_CHANNEL permission to be present on the current user.
  /// If the current user is missing the READ_MESSAGE_HISTORY permission in the channel then this will return no messages (since they cannot read the message history). Returns an array of message objects on success.
  func getChannelMessages(id: Snowflake) async throws -> [Message]
  
  func createMessage(channelID: Snowflake, draft: Message.Draft) async throws -> Message
}

final class ChannelServiceImpl: ChannelService {
  private let networkingService: NetworkingService
  
  init(networkingService: NetworkingService) {
    self.networkingService = networkingService
  }
  
  func getChannelMessages(id: Snowflake) async throws -> [Message] {
    try await networkingService.request(method: .get, path: "/channels/\(id.stringValue)/messages")
  }
  
  func createMessage(channelID: Snowflake, draft: Message.Draft) async throws -> Message {
    try await networkingService.request(method: .post,
                                        path: "/channels/\(channelID.stringValue)/messages",
                                        body: draft)
  }
}
