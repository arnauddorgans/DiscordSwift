// DiscordExample
// 

import Foundation
import SwiftUI
import Discord
import SDWebImageSwiftUI

struct ChatView: View {
  let channel: Channel?
  let messages: [MessageItem]
  
  @State var message: String = ""
  
  var body: some View {
    VStack {
      ScrollView {
        LazyVStack(alignment: .leading) {
          ForEach(messages, id: \.message.id) { message in
            MessageView(item: message)
          }
        }
      }
      HStack {
        TextField("Message", text: $message)
        Button("Send", action: {
          guard let channelID = channel?.id else { return }
          Task {
            do {
              print(try await Discord.shared.channelService.createMessage(channelID: channelID,
                                                                          draft: .init(content: message)))
            } catch {
              print(error)
            }
          }
        })
      }
    }
    .background(Color("ChatBackground"))
  }
}

struct MessageView: View {
  let item: MessageItem
  @State var hover: Bool = false
  
  var avatarURL: URL {
    if let avatar = item.message.author.avatar {
      return Discord.shared.imageURLService.userAvatar(userID: item.message.author.id, hash: avatar)
    } else {
      return Discord.shared.imageURLService.defaultUserAvatar(userDiscriminator: item.message.author.discriminator)
    }
  }
  
  var body: some View {
    HStack(alignment: item.hideAuthor ? .firstTextBaseline : .top, spacing: 16) {
      if item.hideAuthor {
        Text(item.time)
          .font(.footnote)
          .foregroundColor(hover ? .secondary : .clear)
          .frame(width: 38, alignment: .trailing)
      } else {
        WebImage(url: avatarURL)
          .resizable()
          .scaledToFill()
          .frame(width: 38, height: 38)
          .clipShape(Circle())
      }
      VStack(alignment: .leading, spacing: 4) {
        if !item.hideAuthor {
          Text(item.message.author.username)
            .bold()
        }
        Text(item.message.content)
      }
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(hover ? Color("ChatHoverBackground") : .clear)
    .padding(.top, !item.hideAuthor ? 15 : 0)
    .onHover { hover in
      self.hover = hover
    }
  }
}

struct MessageItem {
  let message: Message
  let time: String
  let hideAuthor: Bool
}
