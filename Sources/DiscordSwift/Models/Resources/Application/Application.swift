// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/resources/application#application-object-application-structure
public struct Application: Codable {
  /// The id of the app
  public let id: Snowflake
  /// The name of the app
  public let name: String
  /// The icon hash of the app
  public let icon: String?
  /// The description of the app
  public let description: String
  /// An array of rpc origin urls, if rpc is enabled
  public let rpcOrigins: [String]?
  /// When false only app owner can join the app's bot to guilds
  public let botPublic: Bool
  /// When true the app's bot will only join upon completion of the full oauth2 code grant flow
  public let botRequireCodeGrant: Bool
  /// The url of the app's terms of service
  public let termsOfServiceURL: URL?
  /// The url of the app's privacy policy
  public let privacyPolicyURL: URL?
  /// Partial user object containing info on the owner of the application
  public let owner: User?
  /// The hex encoded key for verification in interactions and the GameSDK's GetTicket
  public let verifyKey: String
  /// If the application belongs to a team, this will be a list of the members of that team
  public let team: Team?
  /// If this application is a game sold on Discord, this field will be the guild to which it has been linked
  public let guildID: Snowflake?
  /// If this application is a game sold on Discord, this field will be the id of the "Game SKU" that is created, if exists
  public let primarySKU: Snowflake?
  /// If this application is a game sold on Discord, this field will be the URL slug that links to the store page
  public let slug: String?
  /// The application's default rich presence invite cover image hash
  public let coverImage: String?
  /// The application's public flags
  public let flags: Flags?
  /// Up to 5 tags describing the content and functionality of the application
  public let tags: [String]?
  /// Settings for the application's default in-app authorization link, if enabled
  public let installParams: InstallParams?
  /// The application's default custom authorization link, if enabled
  public let customInstallURL: URL?
}

extension Application {
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case icon
    case description
    case rpcOrigins = "rpc_origins"
    case botPublic
    case botRequireCodeGrant = "bot_require_code_grant"
    case termsOfServiceURL = "terms_of_service_url"
    case privacyPolicyURL = "privacy_policy_url"
    case owner
    case verifyKey = "verify_key"
    case team
    case guildID = "guild_id"
    case primarySKU = "primary_sku_id"
    case slug
    case coverImage = "cover_image"
    case flags
    case tags
    case installParams = "install_params"
    case customInstallURL = "custom_install_url"
  }
}
