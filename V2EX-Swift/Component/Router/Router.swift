//
//  Router.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum Router: String {
    case toast
    case alert
    case sheet
    case popup
    case login
    case test
    
    var urlString: String {
        "\(UIApplication.shared.scheme)://\(self.rawValue)"
    }

    static func initialize(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
        self.web(provider, navigator)
        self.page(provider, navigator)
        self.model(provider, navigator)
    }
    
}
