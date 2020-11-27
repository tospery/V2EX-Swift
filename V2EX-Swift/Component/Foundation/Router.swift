//
//  Router.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum Router {
    case toast
    case alert
    case sheet
    case popup
    case test
    
    var urlString: String {
        var path: String?
        switch self {
        case .toast:
            path = "toast"
        case .alert:
            path = "alert"
        case .sheet:
            path = "sheet"
        case .popup:
            path = "popup"
        case .test:
            path = "test"
        }
        return UIApplication.shared.scheme + "://" + path!
    }

    static func initialize(_ provider: SWFrame.ProviderType, _ navigator: NavigatorType) {
//        self.web(provider, navigator)
//        self.model(provider, navigator)
//        self.page(provider, navigator)
    }

//    static func web(_ provider: ProviderType, _ navigator: NavigatorType) {
//        let webFactory: ViewControllerFactory = { (url: URLConvertible, values: [String: Any], context: Any?) in
//            guard let url = url.urlValue else { return nil }
//            // (1) 原生支持
//            let string = url.absoluteString
//            let base = UIApplication.shared.baseWebUrl + "/"
//            if string.hasPrefix(base) {
//                let url = string.replacingOccurrences(of: base, with: UIApplication.shared.scheme + "://")
//                if navigator.push(url, context: context) != nil {
//                    return nil
//                }
//            }
//            // (2) 网页跳转
//            var paramters = [Parameter.url: url.absoluteString]
//            if let title = url.queryValue(for: Parameter.title) {
//                paramters[Parameter.title] = title
//            }
//
//            return WebViewController(navigator, WebViewReactor(provider, paramters))
//        }
//        navigator.register("http://<path:_>", webFactory)
//        navigator.register("https://<path:_>", webFactory)
//    }
//
//    static func page(_ provider: ProviderType, _ navigator: NavigatorType) {
//        let parameters = { (url: URLConvertible, values: [String: Any], context: Any?) -> [String: Any]? in
//            var parameters: [String: Any] = url.queryParameters
//            for (key, value) in values {
//                parameters[key] = value
//            }
//            if let context = context {
//                parameters[Parameter.routeContext] = context
//            }
//            return parameters
//        }
//        navigator.register(self.pcgames.urlString) { url, values, context in
//            GamePageViewController(navigator, GamePageViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.login.urlString) { url, values, context in
//            LoginViewController(navigator, LoginViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.register.urlString) { url, values, context in
//            RegisterViewController(navigator, RegisterViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.install.urlString) { url, values, context in
//            InstallViewController(navigator, InstallViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.mcc.urlString) { url, values, context in
//            MccViewController(navigator, MccViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.support.urlString) { url, values, context in
//            SupportViewController(navigator, SupportViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.game.urlString) { url, values, context in
//            GameViewController(navigator, GameViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.server.urlString) { url, values, context in
//            ServerViewController(navigator, ServerViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.accelerate.urlString) { url, values, context in
//            AccelerateViewController(navigator, AccelerateViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.about.urlString) { url, values, context in
//            AboutViewController(navigator, AboutViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.manage.urlString) { url, values, context in
//            ManageViewController(navigator, ManageViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.pay.urlString) { url, values, context in
//            PayViewController(navigator, PayViewReactor(provider, parameters(url, values, context)))
//        }
//        navigator.register(self.test.urlString) { url, values, context in
//            TestViewController(navigator, TestViewReactor(provider, parameters(url, values, context)))
//        }
//    }
    
}
