// 
// 

import Foundation

protocol AuthenticationDataService: AnyObject {
  var clientID: String? { get set }
  var clientSecret: String? { get set }
  var token: Token? { get set }
}

final class AuthenticationDataServiceImpl: AuthenticationDataService {
  var clientID: String?
  var clientSecret: String?
  var token: Token?
}
