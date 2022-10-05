//
//

import Foundation
import Discord
import SwiftUI
import Combine

struct ChannelsMenuView: View {
  let items: [ChannelItem]
  let onSelect: (ChannelItem) -> Void
  
  var body: some View {
    ScrollView {
      LazyVStack {
        Spacer()
          .frame(height: 5)
        ForEach(items, id: \.channel.id) { item in
          ChannelGroupItem(item: item, onTap: {
            onSelect($0)
          })
        }
      }
    }
    .background(Color("ChannelsBackground"))
    .frame(width: 240)
  }
}

struct ChannelGroupItem: View {
  let item: ChannelItem
  let onTap: (ChannelItem) -> Void
  
  var body: some View {
    Group {
      ZStack(alignment: .leading) {
        Text(item.channel.name ?? "")
          .foregroundColor(item.isSelected ? .white : .gray)
          .padding(.horizontal)
        RoundedRectangle(cornerRadius: 8)
          .foregroundColor(item.isSelected ? .white.opacity(0.1) : .clear)
      }
      .padding(.horizontal)
      .frame(height: 35)
      .onTapGesture {
        onTap(item)
      }
      if item.isExpanded {
        ForEach(item.subItems, id: \.channel.id) { item in
          ChannelGroupItem(item: item, onTap: onTap)
        }
      }
    }
  }
}

struct ChannelItem {
  let channel: Channel
  let isSelected: Bool
  let isExpanded: Bool
  let subItems: [ChannelItem]
}

extension Array where Element == ChannelItem {
  func flatten() -> [ChannelItem] {
    self.flatMap { [[$0], $0.subItems.flatten()].flatMap { $0 } }
  }
}
