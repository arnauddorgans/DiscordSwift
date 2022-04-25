// 
// 

import Foundation

/// - seealso: https://discord.com/developers/docs/topics/opcodes-and-status-codes#http-http-response-codes
enum HTTPResponseCode: Int, Encodable {
  /// The request completed successfully.
  case ok = 200
  /// The entity was created successfully.
  case created = 201
  /// The request completed successfully but returned no content.
  case noContent = 204
  /// The entity was not modified (no action was taken).
  case notModified = 304
  /// The request was improperly formatted, or the server couldn't understand it.
  case badRequest = 400
  /// The Authorization header was missing or invalid.
  case unauthorized = 401
  /// The Authorization token you passed did not have permission to the resource.
  case forbidden = 403
  /// The resource at the location specified doesn't exist.
  case notFound = 404
  /// The HTTP method used is not valid for the location specified.
  case methodNotAllowed = 405
  /// You are being rate limited, see Rate Limits.
  case tooManyRequests = 429
  /// There was not a gateway available to process your request. Wait a bit and retry.
  case gatewayUnavailable = 502
  /// The server had an error processing your request (these are rare).
  case serverError = 500
  
  var isError: Bool {
    switch self {
    case .ok, .created, .noContent, .notModified:
      return false
    case .badRequest, .unauthorized, .forbidden, .notFound,
        .methodNotAllowed, .tooManyRequests, .gatewayUnavailable,
        .serverError:
      return true
    }
  }
}

// MARK: Decodable
extension HTTPResponseCode: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let rawValue = try container.decode(Int.self)
    if let httpResponseCode = HTTPResponseCode(rawValue: rawValue) {
      self = httpResponseCode
    } else if rawValue >= 500 && rawValue < 600 {
      self = .serverError
    } else {
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Invalid HTTP response code"))
    }
  }
}
