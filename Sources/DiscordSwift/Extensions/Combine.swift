// 
// 

import Foundation
#if canImport(Combine)
import Combine
public typealias AnyPublisher = Combine.AnyPublisher
public typealias PassthroughSubject = Combine.PassthroughSubject
#else
public protocol Publisher {
  associatedtype Output
  associatedtype Failure: Error
  
  func sink(receiveValue: @escaping ((Output) -> Void)) -> Cancellable
}

public extension Publisher {
  func eraseToAnyPublisher() -> AnyPublisher<Output, Failure> {
    .init(publisher: self)
  }
}

extension Publisher {
  func map<T>(_ transform: @escaping (Output) -> T) -> MapPublisher<Self, T, Failure> {
    .init(publisher: self, map: transform)
  }
}

public protocol Cancellable {
  func cancel()
}

public extension Cancellable {
  func store(in set: inout Set<AnyCancellable>) {
    set.insert(AnyCancellable(cancel))
  }
  
  func store<C>(in collection: inout C) where C: RangeReplaceableCollection, C.Element == AnyCancellable {
    collection.append(AnyCancellable(cancel))
  }
}

struct MapPublisher<T, Output, Failure>: Publisher where T: Publisher, T.Failure == Failure {
  let publisher: T
  let map: (T.Output) -> Output
  
  func sink(receiveValue: @escaping ((Output) -> Void)) -> Cancellable {
    publisher.sink(receiveValue: {
      receiveValue(map($0))
    })
  }
}

public struct AnyPublisher<Output, Failure>: Publisher where Failure: Error {
  private let sink: (@escaping (Output) -> Void) -> Cancellable
  
  init<T>(publisher: T) where T: Publisher, T.Output == Output {
    sink = {
      publisher.sink(receiveValue: $0)
    }
  }
  
  public func sink(receiveValue: @escaping ((Output) -> Void)) -> Cancellable {
    sink(receiveValue)
  }
}

public final class CurrentValueSubject<Output, Failure>: Publisher where Failure: Error {
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

public final class PassthroughSubject<Output, Failure>: Publisher where Failure: Error {
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

public extension PassthroughSubject where Output == Void {
  func send() {
    send(())
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

public final class AnyCancellable: Cancellable {
  private let onCancel: () -> Void
  private var isCancelled: Bool = false
  
  public init(_ onCancel: @escaping () -> Void) {
    self.onCancel = onCancel
  }
  
  public func cancel() {
    guard !isCancelled else { return }
    isCancelled = true
    onCancel()
  }
  
  deinit {
    cancel()
  }
}

extension AnyCancellable: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(ObjectIdentifier(self))
  }
  
  public static func == (lhs: AnyCancellable, rhs: AnyCancellable) -> Bool {
    lhs === rhs
  }
}

@propertyWrapper
struct Published<T> {
  private let currentValueSubject: CurrentValueSubject<T, Never>
  var wrappedValue: T {
    get { currentValueSubject.value }
    set { currentValueSubject.value = newValue }
  }
  
  var projectedValue: CurrentValueSubject<T, Never> { currentValueSubject }
  
  init(wrappedValue: T) {
    currentValueSubject = .init(wrappedValue)
  }
}
#endif
