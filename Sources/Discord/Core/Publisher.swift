// 
// 

import Foundation

public protocol Publisher {
  associatedtype Output
  
  func sink(receiveValue: @escaping ((Output) -> Void)) -> Cancellable
}

public protocol Cancellable {
  func cancel()
}

public final class CurrentValueSubject<Output>: Publisher {
  private let subscriptionBox: SubscriptionBox<Output> = .init()
  public var value: Output {
    willSet { sendAll(newValue: newValue) }
  }
  
  public init(_ output: Output) {
    self.value = output
  }
  
  public func sink(receiveValue: @escaping ((Output) -> Void)) -> Cancellable {
    let subscriptionCancellable = subscriptionBox.add(subscriber: receiveValue)
    // Send current value on sink
    send(value: value, subscription: subscriptionCancellable.subscription)
    return subscriptionCancellable.cancellable
  }
  
  private func send(value: Output, subscription: Subscription<Output>) {
    subscription.receiveValue(value)
  }
  
  private func sendAll(newValue: Output) {
    subscriptionBox.subscriptions.forEach { subscription in
      send(value: newValue, subscription: subscription)
    }
  }
}

public final class PassthroughSubject<Output>: Publisher {
  private let subscriptionBox: SubscriptionBox<Output> = .init()

  public init() { }
  
  public func send(_ output: Output) {
    sendAll(newValue: output)
  }
  
  public func sink(receiveValue: @escaping ((Output) -> Void)) -> Cancellable {
    let subscriptionCancellable = subscriptionBox.add(subscriber: receiveValue)
    return subscriptionCancellable.cancellable
  }
  
  private func send(value: Output, subscription: Subscription<Output>) {
    subscription.receiveValue(value)
  }
  
  private func sendAll(newValue: Output) {
    subscriptionBox.subscriptions.forEach { subscription in
      send(value: newValue, subscription: subscription)
    }
  }
}

// MARK: Subscription
private final class SubscriptionBox<Output> {
  var subscriptions: [Subscription<Output>] = []
  
  func add(subscriber: @escaping (Output) -> Void) -> (subscription: Subscription<Output>, cancellable: Cancellable) {
    let subscription = Subscription<Output>(receiveValue: subscriber)
    subscriptions.append(subscription)
    let cancellable = AnyCancellable { [weak self] in
      self?.subscriptions.removeAll(where: { $0.id == subscription.id })
    }
    return (subscription, cancellable)
  }
}

private struct Subscription<Output> {
  let id: UUID = .init()
  let receiveValue: (Output) -> Void
}

private struct AnyCancellable: Cancellable {
  let onCancel: () -> Void
  
  func cancel() {
    onCancel()
  }
}
