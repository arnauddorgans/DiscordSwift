// 
// 

import Foundation

protocol WebSocketService {
  func connect(url: URL,
               handle: @escaping (Data) -> Void,
               onClose: @escaping (Int) -> Void) async throws
  
  func send(data: Data) async throws
  
  func close() async throws
}
