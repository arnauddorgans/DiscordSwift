// DiscordExample
// 

import Foundation
import SwiftUI
import Discord
import SDWebImageSwiftUI

struct GuildsMenuView: View {
  let guilds: [PartialGuild]
  let selectedGuild: PartialGuild?
  let onSelect: (PartialGuild) -> Void
  
  var body: some View {
    ScrollView {
      LazyVStack {
        Spacer()
          .frame(height: 5)
        ForEach(guilds, id: \.id) { guild in
          WebImage(url: Discord.shared.imageURLService.guildIcon(guildID: guild.id, hash: guild.icon!))
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .onTapGesture {
              onSelect(guild)
            }
        }
      }
    }
    .background(Color("GuildsBackground"))
    .frame(width: 72)
  }
}
