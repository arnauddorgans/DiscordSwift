// 
// 

import Foundation

enum GatewayData {
  case none
  case hello(GatewayHello)
  case heartbeat(sequenceNumber: Int?)
  case identify(GatewayIdentify)
  case ready(GatewayReady)
  case messageCreate(Message)
}
