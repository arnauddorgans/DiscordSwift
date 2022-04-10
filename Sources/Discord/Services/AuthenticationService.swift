// 
// 

import Foundation

protocol AuthenticationService {
  var authentication: Authentication? { get }
  
  func setAuthentication(_ authentication: Authentication?)
}

final class AuthenticationServiceImpl: AuthenticationService {
  var authentication: Authentication?
  
  func setAuthentication(_ authentication: Authentication?) {
    self.authentication = authentication
  }
}
