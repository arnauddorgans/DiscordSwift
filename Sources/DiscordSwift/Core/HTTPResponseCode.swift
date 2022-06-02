// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/opcodes-and-status-codes#http-http-response-codes
enum HTTPResponseCode {
  /// The request completed successfully.
  case ok
  /// The entity was created successfully.
  case created
  /// The request completed successfully but returned no content.
  case noContent
  /// The entity was not modified (no action was taken).
  case notModified
  /// The request was improperly formatted, or the server couldn't understand it.
  case badRequest
  /// The Authorization header was missing or invalid.
  case unauthorized
  /// The Authorization token you passed did not have permission to the resource.
  case forbidden
  /// The resource at the location specified doesn't exist.
  case notFound
  /// The HTTP method used is not valid for the location specified.
  case methodNotAllowed
  /// You are being rate limited, see Rate Limits.
  case tooManyRequests
  /// There was not a gateway available to process your request. Wait a bit and retry.
  case gatewayUnavailable
  /// The server had an error processing your request (these are rare).
  case serverError
  /// Unknown code
  case unknown(Int)
  
  var isError: Bool {
    switch self {
    case .ok, .created, .noContent, .notModified:
      return false
    case .badRequest, .unauthorized, .forbidden, .notFound,
        .methodNotAllowed, .tooManyRequests, .gatewayUnavailable,
        .serverError, .unknown:
      return true
    }
  }
  
  init(rawValue: Int) {
    switch rawValue {
    case 200:
      self = .ok
    case 201:
      self = .created
    case 204:
      self = .noContent
    case 304:
      self = .notModified
    case 400:
      self = .badRequest
    case 401:
      self = .unauthorized
    case 403:
      self = .forbidden
    case 404:
      self = .notFound
    case 405:
      self = .methodNotAllowed
    case 429:
      self = .tooManyRequests
    case 502:
      self = .gatewayUnavailable
    case 500..<600:
      self = .serverError
    default:
      self = .unknown(rawValue)
    }
  }
}
