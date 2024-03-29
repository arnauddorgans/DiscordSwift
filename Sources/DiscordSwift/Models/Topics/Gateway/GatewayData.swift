// 
// 

import Foundation

enum GatewayData {
  case none
  case hello(GatewayHello)
  case heartbeat(sequenceNumber: Int?)
  case identify(GatewayIdentify)
  case resume(GatewayResume)
  case resumed
  case ready(GatewayReady)
  case invalidSession(resumable: Bool)
  case reconnect
  case messageCreate(Message)
  case messageUpdate(Message)
  case messageDelete(GatewayMessageDelete)
  case interactionCreate(Interaction)
}
