// 
// 

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol NetworkingService {
  func request(method: HTTPMethod, path: String, queryItems: [URLQueryItem]) async throws
  
  func request<Body>(method: HTTPMethod, path: String, queryItems: [URLQueryItem], body: Body) async throws where Body: Encodable
  
  func request<Response>(method: HTTPMethod, path: String, queryItems: [URLQueryItem]) async throws -> Response where Response: Decodable
  
  func request<Body, Response>(method: HTTPMethod, path: String, queryItems: [URLQueryItem], body: Body) async throws -> Response where Body: Encodable, Response: Decodable
}

extension NetworkingService {
  func request(method: HTTPMethod, path: String) async throws {
    try await request(method: method, path: path, queryItems: [])
  }
  
  func request<Body>(method: HTTPMethod, path: String, body: Body) async throws where Body: Encodable {
    try await request(method: method, path: path, queryItems: [], body: body)
  }
  
  func request<Response>(method: HTTPMethod, path: String) async throws -> Response where Response: Decodable {
    try await request(method: method, path: path, queryItems: [])
  }
  
  func request<Body, Response>(method: HTTPMethod, path: String, body: Body) async throws -> Response where Body: Encodable, Response: Decodable {
    try await request(method: method, path: path, queryItems: [], body: body)
  }
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
  
  func request(method: HTTPMethod, path: String, queryItems: [URLQueryItem]) async throws {
    let _: NoBody = try await request(method: method, path: path, queryItems: queryItems)
  }
  
  func request<Body>(method: HTTPMethod, path: String, queryItems: [URLQueryItem], body: Body) async throws where Body : Encodable {
    let _: NoBody = try await request(method: method, path: path, queryItems: queryItems, body: body)
  }
  
  func request<Response>(method: HTTPMethod, path: String, queryItems: [URLQueryItem]) async throws -> Response where Response: Decodable {
    try await request(method: method, path: path, queryItems: queryItems, body: NoBody())
  }
  
  func request<Body, Response>(method: HTTPMethod, path: String, queryItems: [URLQueryItem], body: Body) async throws -> Response where Body: Encodable, Response: Decodable {
    let urlSession = URLSession.shared
    let urlRequest = try urlRequest(method: method, path: path, queryItems: queryItems, body: body)
    let dataResponse = try await urlSession.dataResponse(for: urlRequest)
    let httpURLResponse = try (dataResponse.response as? HTTPURLResponse).unwrapped()
    let httpResponseCode = try HTTPResponseCode(rawValue: httpURLResponse.statusCode).unwrapped()
    if httpResponseCode.isError {
      let error = try jsonDecoder.decode(ErrorMessage.self, from: dataResponse.data)
      throw error
    } else {
      if Response.self == NoBody.self {
        return try (NoBody() as? Response).unwrapped()
      } else {
        return try jsonDecoder.decode(Response.self, from: dataResponse.data)
      }
    }
  }
}

private extension NetworkingServiceImpl {
  func url(path: String, queryItems: [URLQueryItem]) throws -> URL {
    let string = environmentService.apiBaseURL + "/" + environmentService.apiVersion.rawValue + path
    var urlComponents = try URLComponents(string: string).unwrapped()
    urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
    return try urlComponents.url.unwrapped()
  }
  
  func urlRequest<T>(method: HTTPMethod, path: String, queryItems: [URLQueryItem], body: T) throws -> URLRequest where T: Encodable {
    let url = try url(path: path, queryItems: queryItems)
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

private struct NoBody: Codable { }

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
