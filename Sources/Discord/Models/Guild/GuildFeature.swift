// 
// 

import Foundation

public extension Guild {
  /// - seealso: https://discord.com/developers/docs/resources/guild#guild-object-guild-features
  enum Feature: String, Codable {
    /// Guild has access to set an animated guild banner image
    case animatedBanner = "ANIMATED_BANNER"
    /// Guild has access to set an animated guild icon
    case animatedIcon = "ANIMATED_ICON"
    /// Guild has access to set a guild banner image
    case banner = "BANNER"
    /// Guild has access to use commerce features (i.e. create store channels)
    case commerce = "COMMERCE"
    /// Guild can enable welcome screen, Membership Screening, stage channels and discovery, and receives community updates
    case community = "COMMUNITY"
    /// Guild is able to be discovered in the directory
    case discoverable = "DISCOVERABLE"
    /// Guild is able to be featured in the directory
    case featurable = "FEATURABLE"
    /// Guild has access to set an invite splash background
    case inviteSplash = "INVITE_SPLASH"
    /// Guild has enabled Membership Screening
    case memberVerificationGateEnabled = "MEMBER_VERIFICATION_GATE_ENABLED"
    /// Guild has enabled monetization
    case monetizationEnabled = "MONETIZATION_ENABLED"
    /// Guild has increased custom sticker slots
    case moreStickers = "MORE_STICKERS"
    /// Guild has access to create news channels
    case news = "NEWS"
    /// Guild is partnered
    case partnered = "PARTNERED"
    /// Guild can be previewed before joining via Membership Screening or the directory
    case previewEnabled = "PREVIEW_ENABLED"
    /// Guild has access to create private threads
    case privateThreads = "PRIVATE_THREADS"
    /// Guild is able to set role icons
    case roleIcons = "ROLE_ICONS"
    /// Guild has access to the seven day archive time for threads
    case sevenDayThreadArchive = "SEVEN_DAY_THREAD_ARCHIVE"
    /// Guild has access to the three day archive time for threads
    case threeDayThreadArchive = "THREE_DAY_THREAD_ARCHIVE"
    /// Guild has enabled ticketed events
    case ticketedEventsEnabled = "TICKETED_EVENTS_ENABLED"
    /// Guild has access to set a vanity URL
    case vanityURL = "VANITY_URL"
    /// Guild is verified
    case verified = "VERIFIED"
    /// Guild has access to set 384kbps bitrate in voice (previously VIP voice servers)
    case vipRegions = "VIP_REGIONS"
    /// Guild has enabled the welcome screen
    case welcomeScreenEnabled = "WELCOME_SCREEN_ENABLED"
  }
}
