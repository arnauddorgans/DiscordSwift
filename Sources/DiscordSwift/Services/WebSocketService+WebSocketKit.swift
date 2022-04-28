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
    let previousWebSocket = webSocket
    webSocket = nil
    try? await previousWebSocket?.close(code: .unknown(0))
    try await WebSocket.connect(to: url, on: eventLoopGroup) { [weak self] ws -> Void in
      self?.webSocket = ws
      ws.onText { ws, string in
        self?.handleText(text: string, webSocket: ws, handle: handle)
      }
      ws.onClose.whenComplete { _ in
        self?.handleClose(webSocket: ws, onClose: onClose)
      }
    }.get()
  }
  
  private func handleText(text: String, webSocket: WebSocket, handle: @escaping (Data) -> Void) {
    guard let data = text.data(using: stringEncoding), webSocket === self.webSocket else { return }
    handle(data)
  }
  
  private func handleClose(webSocket: WebSocket, onClose: @escaping (Int) -> Void) {
    guard let closeCode = webSocket.closeCode, webSocket === self.webSocket else { return }
    let raw = UInt16(webSocketErrorCode: closeCode)
    onClose(Int(raw))
  }
  
  func send(data: Data) async throws {
    let string = try String(data: data, encoding: stringEncoding).unwrapped()
    try await webSocket.unwrapped().send(string)
  }
  
  func close() async throws {
    let webSocket = try webSocket.unwrapped()
    try await webSocket.close(code: .goingAway)
  }
}
#endif
