// 
// 

import Foundation

public enum GatewayEvent {
  case messageCreate(Message)
  case messageUpdate(Message)
  case messageDelete(GatewayMessageDelete)
}
