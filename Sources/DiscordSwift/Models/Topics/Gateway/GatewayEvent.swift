// 
// 

import Foundation

public enum GatewayEvent {
  case messageCreate(Message)
  case messageUpdate(Partial<Message>)
  case messageDelete(GatewayMessageDelete)
  case interactionCreate(Interaction)
}
