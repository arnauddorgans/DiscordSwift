// 
// 

import Foundation
import DiscordSwift
import ArgumentParser
#if canImport(Combine)
import Combine
#endif

@main
struct App: AsyncParsableCommand {
  @Argument var token: String
  
  func run() async throws {
    print("Starting...")
    let discord: Discord = .shared
    discord.auth.setAuthentication(.botToken(token))
    let subscription = subscribeAndEchoMessages(discord: discord)
    try await discord.gateway.connect(intents: [.guildMessages])
    await waitUntilClose(discord: discord)
    subscription.cancel()
  }
  
  private func subscribeAndEchoMessages(discord: Discord) -> AnyCancellable {
    discord.gateway.didReceiveEvent
      .sink(receiveValue: { event in
        guard case let .messageCreate(message) = event, message.author.bot != true else { return }
        Task {
          try await discord.channel.createMessage(channelID: message.channelID,
                                                  draft: .init(message: message))
        }
      })
  }
  
  /// Wait until gateway close
  private func waitUntilClose(discord: Discord) async {
    var cancellables: Set<AnyCancellable> = []
    await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
      discord.gateway.didClose
        .sink(receiveValue: {
          print("Close")
          continuation.resume()
        })
        .store(in: &cancellables)
    }
    cancellables.removeAll()
  }
}

extension Message.Draft {
  init(message: Message) {
    self.init(content: message.content,
              tts: message.tts,
              embeds: message.embeds,
              allowedMentions: nil,
              messageReference: nil,
              components: message.components,
              stickerIDs: message.stickerItems?.map(\.id),
              attachments: message.attachments,
              flags: message.flags)
  }
}
