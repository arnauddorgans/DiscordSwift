// 
// 

import Foundation

protocol NetworkingService {
  func request<T>(method: HTTPMethod, path: String) async throws -> T where T: Decodable
}

final class NetworkingServiceImpl: NetworkingService {
  private let environmentService: EnvironmentService
  private let authenticationService: AuthenticationService
  private lazy var jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .formatted(.iso8601)
    return jsonDecoder
  }()
  
  init(environmentService: EnvironmentService, authenticationService: AuthenticationService) {
    self.environmentService = environmentService
    self.authenticationService = authenticationService
  }
  
  func request<T>(method: HTTPMethod, path: String) async throws -> T where T: Decodable {
    let urlSession = URLSession.shared
    let urlRequest = urlRequest(method: method, path: path)
    let response = try await urlSession.data(for: urlRequest, delegate: nil)
    let httpURLResponse = try (response.1 as? HTTPURLResponse).unwrapped()
    let httpResponseCode = try HTTPResponseCode(rawValue: httpURLResponse.statusCode).unwrapped()
    if httpResponseCode.isError {
      let error = try jsonDecoder.decode(ErrorMessage.self, from: response.0)
      throw error
    } else {
      return try jsonDecoder.decode(T.self, from: response.0)
    }
  }
}

private extension NetworkingServiceImpl {
  func url(path: String) -> URL {
    URL(string: environmentService.apiBaseURL + "/" + environmentService.apiVersion.rawValue + path)!
  }
  
  func urlRequest(method: HTTPMethod, path: String) -> URLRequest {
    let url = url(path: path)
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
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

private extension DateFormatter {
  static var iso8601: DateFormatter {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    return formatter
  }
}
