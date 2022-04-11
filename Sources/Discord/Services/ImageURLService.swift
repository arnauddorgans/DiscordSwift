// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/reference#image-formatting
public protocol ImageURLService {
  /// Custom Emoji
  func customEmoji(id: Snowflake) -> URL
  /// Guild Icon
  func guildIcon(guildID: Snowflake, hash: String) -> URL
  /// Guild Splash
  func guildSplash(guildID: Snowflake, hash: String) -> URL
  /// Guild Discovery Splash
  func guildDiscoverySplash(guildID: Snowflake, hash: String) -> URL
  /// Guild Banner
  func guildBanner(guildID: Snowflake, hash: String) -> URL
  /// User Banner
  func userBanner(userID: Snowflake, hash: String) -> URL
  /// Default User Avatar
  func defaultUserAvatar(userDiscriminator: String) -> URL
  /// User Avatar
  func userAvatar(userID: Snowflake, hash: String) -> URL
  /// Guild Member Avatar
  func guildMemberAvatar(guildID: Snowflake, userID: Snowflake, hash: String) -> URL
  /// Application Icon
  func applicationIcon(applicationID: Snowflake, hash: String) -> URL
  /// Application Cover
  func applicationCover(applicationID: Snowflake, hash: String) -> URL
  /// Application Asset
  func applicationAsset(applicationID: Snowflake, hash: String) -> URL
  /// Achievement Icon
  func achievementIcon(applicationID: Snowflake, achievementID: Snowflake, hash: String) -> URL
  /// Sticker Pack Banner
  func stickerPackBanner(applicationID: Snowflake, hash: String) -> URL
  /// Team Icon
  func teamIcon(teamID: Snowflake, hash: String) -> URL
  /// Sticker
  func sticker(stickerID: Snowflake) -> URL
  /// Role Icon
  func roleIcon(roleID: Snowflake, hash: String) -> URL
  /// Guild Scheduled Event Cover
  func guildScheduledEventCover(eventID: Snowflake, hash: String) -> URL
}

final class ImageURLServiceImpl: ImageURLService {
  private let environmentService: EnvironmentService
  
  init(environmentService: EnvironmentService) {
    self.environmentService = environmentService
  }
  
  func customEmoji(id: Snowflake) -> URL {
    url(path: "/emojis/\(id.stringValue)")
  }

  func guildIcon(guildID: Snowflake, hash: String) -> URL {
    url(path: "/icons/\(guildID.stringValue)/\(hash)")
  }
  
  func guildSplash(guildID: Snowflake, hash: String) -> URL {
    url(path: "/splashes/\(guildID.stringValue)/\(hash)")
  }
  
  func guildDiscoverySplash(guildID: Snowflake, hash: String) -> URL {
    url(path: "/discovery-splashes/\(guildID.stringValue)/\(hash)")
  }
  
  func guildBanner(guildID: Snowflake, hash: String) -> URL {
    url(path: "/banners/\(guildID.stringValue)/\(hash)")
  }
  
  func userBanner(userID: Snowflake, hash: String) -> URL {
    url(path: "/banners/\(userID.stringValue)/\(hash)")
  }
  
  func defaultUserAvatar(userDiscriminator: String) -> URL {
    url(path: "/embed/avatars/\(userDiscriminator)")
  }
  
  func userAvatar(userID: Snowflake, hash: String) -> URL {
    url(path: "/avatars/\(userID.stringValue)/\(hash)")
  }
  
  func guildMemberAvatar(guildID: Snowflake, userID: Snowflake, hash: String) -> URL {
    url(path: "/guilds/\(guildID.stringValue)/users/\(userID.stringValue)/avatars/\(hash)")
  }
  
  func applicationIcon(applicationID: Snowflake, hash: String) -> URL {
    url(path: "/app-icons/\(applicationID.stringValue)/\(hash)")
  }
  
  func applicationCover(applicationID: Snowflake, hash: String) -> URL {
    url(path: "/app-icons/\(applicationID.stringValue)/\(hash)")
  }
  
  func applicationAsset(applicationID: Snowflake, hash: String) -> URL {
    url(path: "/app-assets/\(applicationID.stringValue)/\(hash)")
  }
  
  func achievementIcon(applicationID: Snowflake, achievementID: Snowflake, hash: String) -> URL {
    url(path: "/app-assets/\(applicationID.stringValue)/achievements/\(achievementID.stringValue)/icons/\(hash)")
  }
  
  func stickerPackBanner(applicationID: Snowflake, hash: String) -> URL {
    url(path: "/app-assets/\(applicationID.stringValue)/store/\(hash)")
  }
  
  func teamIcon(teamID: Snowflake, hash: String) -> URL {
    url(path: "/team-icons/\(teamID.stringValue)/\(hash)")
  }
  
  func sticker(stickerID: Snowflake) -> URL {
    url(path: "/stickers/\(stickerID.stringValue)")
  }
  
  func roleIcon(roleID: Snowflake, hash: String) -> URL {
    url(path: "/role-icons/\(roleID.stringValue)/\(hash)")
  }
  
  func guildScheduledEventCover(eventID: Snowflake, hash: String) -> URL {
    url(path: "/guild-events/\(eventID.stringValue)/\(hash)")
  }
}

private extension ImageURLServiceImpl {
  func url(path: String) -> URL {
    URL(string: environmentService.imageBaseURL + path + ".png")!
  }
}
