// 
// 

import Foundation

#if canImport(WebSocketKit)
// See WebSocketService+WebSocketKit.swift
#else
final class WebSocketServiceImpl: NSObject, WebSocketService {
  private var handleData: ((Data) -> Void)?
  private var onClose: ((Int) -> Void)?
  private var socketTask: URLSessionWebSocketTask?
  
  func connect(url: URL, handle: @escaping (Data) -> Void, onClose: @escaping (Int) -> Void) async throws {
    self.onClose = onClose
    handleData = handle
    socketTask = URLSession.shared.webSocketTask(with: url)
    socketTask?.delegate = self
    socketTask?.resume()
    Task {
      try await readMessage()
    }
  }
  
  func send(data: Data) async throws {
    let socketTask = try socketTask.unwrapped()
    try await socketTask.send(.data(data))
  }
  
  private func readMessage() async throws {
    let socketTask = try socketTask.unwrapped()
    let message = try await socketTask.receive()
    let messageData: Data
    switch message {
    case let .data(data):     messageData = data
    case let .string(string): messageData = Data(string.utf8)
    @unknown default: fatalError()
    }
    handleData?(messageData)
    try await readMessage()
  }
}

// MARK: URLSessionTaskDelegate
extension WebSocketServiceImpl: URLSessionWebSocketDelegate {
  func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) { }
  
  func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
    onClose?(closeCode.rawValue)
  }
}
#endif
