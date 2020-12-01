//
//  ProviderType+Networking.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

let networking = Networking(
    provider: MoyaProvider<MultiTarget>(
        endpointClosure: Networking.endpointClosure,
        requestClosure: Networking.requestClosure,
        stubClosure: Networking.stubClosure,
        callbackQueue: Networking.callbackQueue,
        session: Networking.session,
        plugins: Networking.plugins,
        trackInflights: Networking.trackInflights
    )
)

extension SWFrame.ProviderType {
    
    // MARK: - V2EXAPI
    /// V2EX网站信息：https://www.v2ex.com/api/site/info.json
    func siteInfo() -> Single<SiteInfo> {
        networking.requestObject(
            MultiTarget.init(V2EXAPI.siteInfo),
            type: SiteInfo.self
        )
    }
    
    /// V2EX登录验证：https://www.v2ex.com/_captcha?once=[once]
    func captcha() -> Single<LoginViewReactor.Input> {
        networking.requestRaw(
            MultiTarget.init(V2EXAPI.signin)
        )
        .mapString()
        .flatMap { string -> Single<LoginViewReactor.Input> in
            guard
                let doc = try? SwiftSoup.parse(string),
                let element = try? doc.getElementsByAttributeValue("name", "once").first(),
                let elements = try? doc.getElementsByAttributeValue("class", "sl"),
                let once = try? element.attr("value"),
                elements.count >= 3
            else {
                return .error(V2EXError.invalidFormat)
            }
            
            var username: String?
            var password: String?
            var captcha: String?
            for el in elements {
                if let type = try? el.attr("type") {
                    if type == "password" {
                        password = try? el.attr("name")
                    } else if type == "text" {
                        if let placeholder = try? el.attr("placeholder") {
                            if placeholder.contains("用户名") {
                                username = try? el.attr("name")
                            } else if placeholder.contains("验证码") {
                                captcha = try? el.attr("name")
                            }
                        }
                    }
                }
            }
            if username?.isEmpty ?? true ||
                password?.isEmpty ?? true ||
                captcha?.isEmpty ?? true {
                return .error(V2EXError.invalidFormat)
            }
            
            return networking.requestRaw(
                MultiTarget.init(
                    V2EXAPI.captcha(once: once)
                )
            )
            .mapImage()
            .flatMap { .just(
                LoginViewReactor.Input.init(
                    username: username!,
                    password: password!,
                    captcha: captcha!,
                    once: once,
                    image: $0
                )
            )}
        }
    }
    
    func login(
        username: String,
        password: String,
        captcha: String,
        input: LoginViewReactor.Input
    ) -> Single<User> {
        networking.requestRaw(
            MultiTarget.init(
                V2EXAPI.login(
                    username: username,
                    password: password,
                    captcha: captcha,
                    input: input
                )
            )
        )
        .mapString()
        .flatMap { string -> Single<User> in
            log("html: \(string)")
            guard
                let doc = try? SwiftSoup.parse(string),
                let element = try? doc.getElementsByAttributeValue("alt", "tospery").first(),
                let avatar = try? element.attr("src")
            else {
                return .error(V2EXError.invalidFormat)
            }
            log("avatar = \(avatar)")
            return .just(User.init())
        }
    }
    
}
