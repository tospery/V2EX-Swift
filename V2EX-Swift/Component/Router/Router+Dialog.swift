//
//  Router+Dialog.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

extension Router {
    
    static func dialog(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        navigator.handle(self.toast.urlString) { url, _, _ -> Bool in
            guard let window = AppDependency.shared.window else { return false }
            if let message = url.queryParameters[Parameter.message] {
                window.makeToast(message)
            } else if let active = url.queryParameters[Parameter.active] {
                (active.bool ?? false) ? window.makeToastActivity(.center) : window.hideToastActivity()
            } else {
                return false
            }
            return true
        }
        navigator.handle(self.alert.urlString) { _, _, _ -> Bool in
            return true
        }
    }
    
}
