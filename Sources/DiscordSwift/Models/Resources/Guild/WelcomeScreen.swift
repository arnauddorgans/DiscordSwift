// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/guild#welcome-screen-object-welcome-screen-structure
public struct WelcomeScreen: Decodable {
  /// The server description shown in the welcome screen
  public let description: String?
  /// Array of welcome screen channel objects  the channels shown in the welcome screen, up to 5
  public let welcomeChannels: [Channel]
}

extension WelcomeScreen {
  enum CodingKeys: String, CodingKey {
    case description
    case welcomeChannels = "welcome_channels"
  }
}
