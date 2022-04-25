// 
// 

import Foundation

public protocol GuildService {
  /// Returns the guild object for the given id.
  /// If with_counts is set to true, this endpoint will also return approximate_member_count and approximate_presence_count for the guild.
  func getGuild(id: Snowflake) async throws -> Guild
  
  /// Returns the guild preview object for the given id. If the user is not in the guild, then the guild must be lurkable.
  func getGuildPreview(id: Snowflake) async throws -> Guild.Preview
  
  /// Returns a list of guild channel objects. Does not include threads.
  func getGuildChannels(id: Snowflake) async throws -> [Channel]
}

final class GuildServiceImpl: GuildService {
  private let networkingService: NetworkingService
  
  init(networkingService: NetworkingService) {
    self.networkingService = networkingService
  }
  
  func getGuild(id: Snowflake) async throws -> Guild {
    try await networkingService.request(method: .get, path: "/guilds/\(id.stringValue)")
  }
  
  func getGuildPreview(id: Snowflake) async throws -> Guild.Preview {
    try await networkingService.request(method: .get, path: "/guilds/\(id.stringValue)/preview")
  }
  
  func getGuildChannels(id: Snowflake) async throws -> [Channel] {
    try await networkingService.request(method: .get, path: "/guilds/\(id.stringValue)/channels")
  }
}
