// DiscordExample
// 

import Foundation
import SwiftUI
import Discord
import SDWebImageSwiftUI

struct RootView: View {
  @State var selectedGuild: PartialGuild?
  @ObservedObject private var viewModel: RootViewModel = .init()
  
  var body: some View {
    HStack(spacing: 0) {
      GuildsMenuView(guilds: viewModel.guilds,
                     selectedGuild: selectedGuild,
                     onSelect: { viewModel.select(guild: $0) })
      ChannelsMenuView(items: viewModel.channels,
                       onSelect: { viewModel.select(channel: $0) })
      ChatView(channel: viewModel.selectedChannel?.channel,
               messages: viewModel.messages)
    }
    .task {
      await viewModel.load()
    }
  }
}

private final class RootViewModel: ObservableObject {
  @Published var selectedGuild: PartialGuild?
  @Published var guilds: [PartialGuild] = []
  
  @Published var channels: [ChannelItem] = []
  @Published var messages: [MessageItem] = []
  
  var selectedChannel: ChannelItem? {
    channels.flatten().first(where: \.isSelected)
  }
    
  func load() async {
    do {
      let guilds = try await Discord.shared.userService.getCurrentUserGuilds()
      await MainActor.run {
        self.guilds = guilds
        if let guild = guilds.first {
          self.select(guild: guild)
        }
      }
    } catch {
      print(error)
    }
  }
  
  func loadChannels() async {
    guard let selectedGuild = selectedGuild else { return }
    do {
      let channels = try await Discord.shared.guildService.getGuildChannels(id: selectedGuild.id)
        .sorted(by: { $0.position ?? 0 < $1.position ?? 0 })
      func item(channel: Channel) -> ChannelItem {
        let subItems = channels
          .filter { $0.parentID == channel.id }
          .map { item(channel: $0) }
        return ChannelItem(channel: channel, isSelected: false, isExpanded: false, subItems: subItems)
      }
      let rootChannels = channels
        .filter { $0.parentID == nil }
        .map { item(channel: $0) }
      await MainActor.run {
        self.channels = rootChannels
      }
    } catch {
      print(error)
    }
  }
  
  func select(guild: PartialGuild) {
    self.selectedGuild = guild
    Task {
      await loadChannels()
    }
  }
  
  func select(channel item: ChannelItem) {
    let select = item.channel.type != .guildCategory
    func map(_ mapItem: ChannelItem) -> ChannelItem {
      ChannelItem(channel: mapItem.channel,
                  isSelected: select ? mapItem.channel.id == item.channel.id : mapItem.isSelected,
                  isExpanded: !select && mapItem.channel.id == item.channel.id ? !mapItem.isExpanded : mapItem.isExpanded,
                  subItems: mapItem.subItems.map(map))
    }
    channels = channels.map(map)
    Task {
      await loadMessages()
    }
  }
  
  func loadMessages() async {
    guard let channel = selectedChannel?.channel else { return }
    do {
      let messages = try await Discord.shared.channelService.getChannelMessages(id: channel.id)
      await MainActor.run {
        self.messages = messages.reversed().reduce(into: [], { items, message in
          let time = DateFormatter.localizedString(from: message.timestamp, dateStyle: .none, timeStyle: .short)
          let sameAuthor = items.last?.message.author.id == message.author.id
          let shortInterval = items.last.flatMap { message.timestamp.timeIntervalSince($0.message.timestamp) < 60 * 60 } ?? false
          items.append(.init(message: message,
                             time: time,
                             hideAuthor: sameAuthor && shortInterval))
        })
      }
    } catch {
      print(error)
    }
  }
}
