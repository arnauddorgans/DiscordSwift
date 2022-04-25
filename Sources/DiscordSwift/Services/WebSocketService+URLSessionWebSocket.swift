// 
// 

import Foundation

#if canImport(WebSocketKit)
// See WebSocketService+WebSocketKit.swift
#else
final class WebSocketServiceImpl: NSObject, WebSocketService {
  private var handleData: ((Data) -> Void)?
  private var didConnect: ((Result<Void, Error>) -> Void)?
  private var onClose: ((Int) -> Void)?
  private var socketTask: URLSessionWebSocketTask?
  
  func connect(url: URL, handle: @escaping (Data) -> Void, onClose: @escaping (Int) -> Void) async throws {
    self.onClose = onClose
    handleData = handle
    let previousSocketTask = socketTask
    socketTask = URLSession.shared.webSocketTask(with: url)
    socketTask?.delegate = self
    previousSocketTask?.cancel()
    try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<Void, Error>) in
      didConnect = continuation.resume(with:)
      socketTask?.resume()
    })
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
  func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
    handleConnect(task: webSocketTask, result: .success(()))
  }
  
  func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
    handleClose(task: webSocketTask, closeCode: closeCode)
  }
  
  func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
    guard let error = error else { return }
    handleConnect(task: task, result: .failure(error))
  }
  
  private func handleConnect(task: URLSessionTask, result: Result<Void, Error>) {
    guard task === socketTask else { return }
    let didConnect = didConnect
    didConnect?(result)
    self.didConnect = nil
  }
  
  private func handleClose(task: URLSessionTask, closeCode: URLSessionWebSocketTask.CloseCode) {
    guard task === socketTask else { return }
    let onClose = onClose
    onClose?(closeCode.rawValue)
    self.onClose = nil
  }
}
#endif
