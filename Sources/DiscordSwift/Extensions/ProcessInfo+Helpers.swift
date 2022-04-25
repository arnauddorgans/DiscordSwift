// 
// 

import Foundation
#if canImport(UIKit)
import UIKit
#endif

extension ProcessInfo {
  var osName: String {
    #if canImport(UIKit)
    return UIDevice.current.systemName
    #elseif os(macOS)
    return "macOS"
    #elseif os(Linux)
    return "linux"
    #endif
  }
}
