// 
// 

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol NetworkingService {
  @discardableResult
  func request<Response>(method: HTTPMethod, path: String) async throws -> Response where Response: Decodable
  
  @discardableResult
  func request<Body, Response>(method: HTTPMethod, path: String, body: Body) async throws -> Response where Body: Encodable, Response: Decodable
}

final class NetworkingServiceImpl: NetworkingService {
  private let environmentService: EnvironmentService
  private let authenticationService: AuthenticationService
  private lazy var jsonDecoder: JSONDecoder = .iso8601
  private lazy var jsonEncoder: JSONEncoder = .iso8601
  
  init(environmentService: EnvironmentService, authenticationService: AuthenticationService) {
    self.environmentService = environmentService
    self.authenticationService = authenticationService
  }
  
  func request<Response>(method: HTTPMethod, path: String) async throws -> Response where Response: Decodable {
    try await request(method: method, path: path, body: NoBody())
  }
  
  func request<Body, Response>(method: HTTPMethod, path: String, body: Body) async throws -> Response where Body: Encodable, Response: Decodable {
    let urlSession = URLSession.shared
    let urlRequest = try urlRequest(method: method, path: path, body: body)
    let dataResponse = try await urlSession.dataResponse(for: urlRequest)
    let httpURLResponse = try (dataResponse.response as? HTTPURLResponse).unwrapped()
    let httpResponseCode = try HTTPResponseCode(rawValue: httpURLResponse.statusCode).unwrapped()
    if httpResponseCode.isError {
      let error = try jsonDecoder.decode(ErrorMessage.self, from: dataResponse.data)
      throw error
    } else {
      return try jsonDecoder.decode(Response.self, from: dataResponse.data)
    }
  }
}

private extension NetworkingServiceImpl {
  func url(path: String) throws -> URL {
    let string = environmentService.apiBaseURL + "/" + environmentService.apiVersion.rawValue + path
    return try URL(string: string).unwrapped()
  }
  
  func urlRequest<T>(method: HTTPMethod, path: String, body: T) throws -> URLRequest where T: Encodable {
    let url = try url(path: path)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    if !(body is NoBody) {
      urlRequest.httpBody = try jsonEncoder.encode(body)
    }
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    if let authentication = authenticationService.authentication {
      switch authentication {
      case .botToken(let string):
        urlRequest.setValue("Bot \(string)", forHTTPHeaderField: "Authorization")
      case .token(let string):
        urlRequest.setValue("Bearer \(string)", forHTTPHeaderField: "Authorization")
      }
    }
    return urlRequest
  }
}

private struct NoBody: Encodable { }

// MARK: Async Helpers
private extension URLSession {
  func dataResponse(for request: URLRequest) async throws -> (data: Data, response: URLResponse) {
    try await withCheckedThrowingContinuation { continuation in
      let task = dataTask(with: request, completionHandler: { data, urlResponse, error in
        if let error = error {
          continuation.resume(throwing: error)
        } else {
          do {
            try continuation.resume(returning: (data.unwrapped(), urlResponse.unwrapped()))
          } catch {
            continuation.resume(throwing: error)
          }
        }
      })
      task.resume()
    }
  }
}
