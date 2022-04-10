// 
// 

import Foundation

public enum MFALevel: Int, Decodable {
  /// Guild has no MFA/2FA requirement for moderation actions
  case none = 0
  /// Guild has a 2FA requirement for moderation actions
  case elevated = 1
}
