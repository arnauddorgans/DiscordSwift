// 
// 

import Foundation

extension JSONEncoder {
  static var iso8601: JSONEncoder {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.dateEncodingStrategy = .formatted(.iso8601)
    return jsonEncoder
  }
}

extension JSONDecoder {
  static var iso8601: JSONDecoder {
    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .formatted(.iso8601)
    return jsonDecoder
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
