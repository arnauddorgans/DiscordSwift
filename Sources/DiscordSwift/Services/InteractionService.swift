// 
// 

import Foundation

public protocol InteractionService {
  /// Create a response to an Interaction from the gateway.
  /// - seealso: https://discord.com/developers/docs/interactions/receiving-and-responding#create-interaction-response
  func createInteractionResponse(_ response: Interaction.Response,
                                 forInteractionID id: Snowflake,
                                 interactionToken: String) async throws
}

final class InteractionServiceImpl: InteractionService {
  private let networkingService: NetworkingService
  
  init(networkingService: NetworkingService) {
    self.networkingService = networkingService
  }
  
  func createInteractionResponse(_ response: Interaction.Response,
                                 forInteractionID id: Snowflake,
                                 interactionToken: String) async throws {
    try await networkingService.request(method: .post,
                                        path: "/interactions/\(id.stringValue)/\(interactionToken)/callback",
                                        body: response)
  }
}
