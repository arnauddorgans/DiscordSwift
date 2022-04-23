// 
// 

import Foundation
import Discord
import ArgumentParser

@main
struct App: AsyncParsableCommand {
  @Argument var token: String
  
  func run() async throws {
    let discord = Discord.shared
    let gateway = discord.gatewayService
    discord.setAuthentication(.botToken(token))
    gateway.connect(intents: [.guildMessages])
    let cancellable = gateway.didReceiveEvent.sink(receiveValue: { event in
      guard case let .messageCreate(message) = event, message.author.bot != true else { return }
      Task {
        try await discord.channelService.createMessage(channelID: message.channelID,
                                                       draft: .init(message: message))
      }
    })
    let _: Void = await withCheckedContinuation { _ in }
    cancellable.cancel()
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
