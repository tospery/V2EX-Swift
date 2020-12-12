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
    
    /// V2EX用户登录：https://www.v2ex.com/signin
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
        .flatMap { html -> Single<User> in
            guard let doc = try? SwiftSoup.parse(html) else {
                return .error(V2EXError.invalidFormat)
            }
            if let problem = try? doc.getElementsByClass("problem").first(),
               let text = try? problem.getElementsByTag("li").first()?.text() {
                return .error(V2EXError.loginFailure(text))
            }
            if let avatar = try? doc.getElementsByAttributeValue("class", "avatar").first()?.attr("src"),
               !avatar.isEmpty {
                return self.userinfo(username: username)
            }
            return .error(V2EXError.loginFailure(nil))
        }
    }
    
    /// V2EX用户信息：https://www.v2ex.com/api/members/show.json?username=tospery
    func userinfo(username: String) -> Single<User> {
        networking.requestObject(
            MultiTarget.init(
                V2EXAPI.userinfo(username: username)
            ),
            type: User.self
        )
    }
    
    /// V2EX热门节点：https://www.v2ex.com/api/topics/hot.json
    func hot() -> Single<[Node]> {
        networking.requestArray(
            MultiTarget.init(
                V2EXAPI.hot
            ),
            type: Topic.self
        )
        .map { $0.map { $0.node } }
    }

}
