// DiscordExample
// 

import SwiftUI
import Discord

@main
struct DiscordExampleApp: App {
  #if canImport(UIKit)
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  #endif
  #if canImport(AppKit)
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  #endif
  
  var body: some Scene {
    WindowGroup {
      RootView()
    }
  }
}

final class AppDelegate: NSObject {
  func setup() {
    Discord.shared.setAuthentication(.botToken("${token}"))
    Discord.shared.gatewayService.connect(intents: [.guildMessages, .guildMessageTyping])
  }
}

#if canImport(UIKit)
extension AppDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    setup()
    return true
  }
}
#endif

#if canImport(AppKit)
extension AppDelegate: NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
    setup()
  }
}
#endif
