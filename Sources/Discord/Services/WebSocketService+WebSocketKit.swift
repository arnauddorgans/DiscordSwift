// 
// 

#if canImport(WebSocketKit)
import Foundation
import WebSocketKit
import NIO

final class WebSocketServiceImpl: WebSocketService {
  private weak var webSocket: WebSocket?
  private lazy var eventLoopGroup: EventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 2)
  private let stringEncoding: String.Encoding = .utf8
  
  func connect(url: URL,
               handle: @escaping (Data) -> Void,
               onClose: @escaping (Int) -> Void) async throws {
    try await WebSocket.connect(to: url, on: eventLoopGroup) { [weak self] ws async -> Void in
      self?.webSocket = ws
      ws.onText { ws, string in
        guard let stringEncoding = self?.stringEncoding,
              let data = string.data(using: stringEncoding)
        else { return }
        handle(data)
      }
      ws.onClose.whenComplete { result in
        guard let closeCode = ws.closeCode else { return }
        let raw = UInt16(webSocketErrorCode: closeCode)
        onClose(Int(raw))
      }
    }
  }
  
  func send(data: Data) async throws {
    let string = try String(data: data, encoding: stringEncoding).unwrapped()
    try await webSocket?.send(string)
  }
}
#endif
