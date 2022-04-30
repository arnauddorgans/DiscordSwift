// 
// 

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol NetworkingService {
  func urlRequest<Body>(method: HTTPMethod, path: String, queryItems: [URLQueryItem], bodyEncoder: BodyEncoder, body: Body) throws -> URLRequest where Body: Encodable
  func request<Body, Response>(method: HTTPMethod, path: String, queryItems: [URLQueryItem], bodyEncoder: BodyEncoder, body: Body) async throws -> Response where Body: Encodable, Response: Decodable
}

extension NetworkingService {
  func urlRequest(method: HTTPMethod, path: String, queryItems: [URLQueryItem] = [], bodyEncoder: BodyEncoder = .default) throws -> URLRequest {
    try urlRequest(method: method, path: path, queryItems: queryItems, bodyEncoder: bodyEncoder, body: NoBody())
  }
  
  func urlRequest<Body>(method: HTTPMethod, path: String, queryItems: [URLQueryItem] = [], bodyEncoder: BodyEncoder = .default, body: Body) throws -> URLRequest where Body: Encodable {
    try urlRequest(method: method, path: path, queryItems: queryItems, bodyEncoder: bodyEncoder, body: body)
  }
  
  func request(method: HTTPMethod, path: String, queryItems: [URLQueryItem] = [], bodyEncoder: BodyEncoder = .default) async throws {
    let _: NoBody = try await request(method: method, path: path, queryItems: queryItems, bodyEncoder: bodyEncoder)
  }
  
  func request<Body>(method: HTTPMethod, path: String, queryItems: [URLQueryItem] = [], bodyEncoder: BodyEncoder = .default, body: Body) async throws where Body : Encodable {
    let _: NoBody = try await request(method: method, path: path, queryItems: queryItems, bodyEncoder: bodyEncoder, body: body)
  }
  
  func request<Response>(method: HTTPMethod, path: String, queryItems: [URLQueryItem] = [], bodyEncoder: BodyEncoder = .default) async throws -> Response where Response: Decodable {
    try await request(method: method, path: path, queryItems: queryItems, bodyEncoder: bodyEncoder, body: NoBody())
  }

  func request<Body, Response>(method: HTTPMethod, path: String, queryItems: [URLQueryItem] = [], bodyEncoder: BodyEncoder = .default, body: Body) async throws -> Response where Body: Encodable, Response: Decodable {
    try await request(method: method, path: path, queryItems: [], bodyEncoder: bodyEncoder, body: body)
  }
}

final class NetworkingServiceImpl: NetworkingService {
  private let environmentService: EnvironmentService
  private let authenticationDataService: AuthenticationDataService
  private lazy var jsonDecoder: JSONDecoder = .iso8601
  private lazy var jsonEncoder: JSONEncoder = .iso8601
  
  init(environmentService: EnvironmentService, authenticationDataService: AuthenticationDataService) {
    self.environmentService = environmentService
    self.authenticationDataService = authenticationDataService
  }
  
  func urlRequest<T>(method: HTTPMethod, path: String, queryItems: [URLQueryItem], bodyEncoder: BodyEncoder, body: T) throws -> URLRequest where T: Encodable {
    let url = try url(path: path, queryItems: queryItems)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    if !(body is NoBody) {
      switch bodyEncoder {
      case .json:
        urlRequest.httpBody = try jsonEncoder.encode(body)
      case .urlEncodedForm:
        let data = try jsonEncoder.encode(body)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        let dictionary = try (jsonObject as? [String: Any]).unwrapped(NetworkingError.invalidBody)
        var urlComponents = URLComponents()
        urlComponents.queryItems = dictionary.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
      }
    }
    switch bodyEncoder {
    case .json:
      urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    case .urlEncodedForm:
      urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
    if let token = authenticationDataService.token {
      switch token {
      case .botToken:
        urlRequest.setValue("Bot \(token.stringValue)", forHTTPHeaderField: "Authorization")
      case .oauthToken:
        urlRequest.setValue("Bearer \(token.stringValue)", forHTTPHeaderField: "Authorization")
      }
    }
    return urlRequest
  }
  
  func request<Body, Response>(method: HTTPMethod, path: String, queryItems: [URLQueryItem], bodyEncoder: BodyEncoder, body: Body) async throws -> Response where Body: Encodable, Response: Decodable {
    let urlSession = URLSession.shared
    let urlRequest = try urlRequest(method: method, path: path, queryItems: queryItems, bodyEncoder: bodyEncoder, body: body)
    let dataResponse = try await urlSession.dataResponse(for: urlRequest)
    let httpURLResponse = try (dataResponse.response as? HTTPURLResponse).unwrapped(NetworkingError.invalidResponse)
    let httpResponseCode = try HTTPResponseCode(rawValue: httpURLResponse.statusCode).unwrapped(NetworkingError.invalidResponseCode)
    if httpResponseCode.isError {
      let error = try jsonDecoder.decode(ErrorMessage.self, from: dataResponse.data)
      throw error
    } else {
      if Response.self == NoBody.self {
        return try (NoBody() as? Response).unwrapped(NetworkingError.invalidResponse)
      } else {
        return try jsonDecoder.decode(Response.self, from: dataResponse.data)
      }
    }
  }
}

private extension NetworkingServiceImpl {
  func url(path: String, queryItems: [URLQueryItem]) throws -> URL {
    let string = environmentService.apiBaseURL + "/" + environmentService.apiVersion.rawValue + path
    var urlComponents = try URLComponents(string: string).unwrapped(NetworkingError.invalidURL)
    urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
    return try urlComponents.url.unwrapped(NetworkingError.invalidURL)
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
            try continuation.resume(returning: (data.unwrapped(NetworkingError.invalidResponse), urlResponse.unwrapped(NetworkingError.invalidResponse)))
          } catch {
            continuation.resume(throwing: error)
          }
        }
      })
      task.resume()
    }
  }
}

// MARK: Error
private enum NetworkingError: Error {
  case invalidBody
  case invalidURL
  case invalidResponse
  case invalidResponseCode
}
