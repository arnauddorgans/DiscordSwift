// 
// 

import Foundation

/// Users in Discord are generally considered the base entity.
/// Users can spawn across the entire platform, be members of guilds, participate in text and voice chat, and much more.
/// Users are separated by a distinction of "bot" vs "normal."
/// Although they are similar, bot users are automated users that are "owned" by another user.
/// Unlike normal users, bot users do not have a limitation on the number of Guilds they can be a part of.
/// - seealso: https://discord.com/developers/docs/resources/user#user-object
public struct User: Codable {
  /// The user's id  identify
  public let id: Snowflake
  /// The user's username, not unique across the platform  identify
  public let username: String
  /// The user's 4-digit discord-tag  identify
  public let discriminator: Discriminator
  /// The user's avatar hash  identify
  public let avatar: String?
  /// Whether the user belongs to an OAuth2 application  identify
  public let bot: Bool?
  /// Whether the user is an Official Discord System user (part of the urgent message system)  identify
  public let system: Bool?
  /// Whether the user has two factor enabled on their account  identify
  public let mfaEnabled: Bool?
  /// The user's banner hash  identify
  public let banner: String?
  /// The user's banner color encoded as an integer representation of hexadecimal color code  identify
  public let accentColor: Color?
  /// The user's chosen language option  identify
  public let locale: String?
  /// Whether the email on this account has been verified  email
  public let verified: Bool?
  /// The user's email  email
  public let email: String?
  /// The flags on a user's account  identify
  public let flags: UserFlags?
  /// The type of Nitro subscription on a user's account  identify
  public let premiumType: PremiumType?
  /// The public flags on a user's account  identify
  public let publicFlags: UserFlags?
}

extension User {
  enum CodingKeys: String, CodingKey {
    case id
    case username
    case discriminator
    case avatar
    case bot
    case system
    case mfaEnabled = "mfa_enabled"
    case banner
    case accentColor = "accent_color"
    case locale
    case verified
    case email
    case flags
    case premiumType = "premium_type"
    case publicFlags = "public_flags"
  }
}
