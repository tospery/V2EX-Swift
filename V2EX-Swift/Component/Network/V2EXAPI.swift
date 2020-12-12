//
//  V2EXAPI.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum V2EXAPI {
    case siteInfo
    case signin
    case userinfo(username: String)
    case captcha(once: String)
    case login(username: String, password: String, captcha: String, input: LoginViewReactor.Input)
}

extension V2EXAPI: TargetType {

    var baseURL: URL {
        return UIApplication.shared.baseApiUrl.url!
    }

    var path: String {
        switch self {
        case .siteInfo: return "/api/site/info.json"
        case .signin, .login: return "/signin"
        case .captcha: return "/_captcha"
        case .userinfo: return "/api/members/show.json"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }

    var headers: [String: String]? {
        switch self {
        case .login:
            return [
                "Referer": "https://v2ex.com/signin"
            ]
        default:
            return nil
        }
    }

    var task: Task {
        var parameters = [String: Any]()
        switch self {
        case let .captcha(once):
            parameters["once"] = once
        case let .login(username, password, captcha, input):
            parameters[input.username] = username
            parameters[input.password] = password
            parameters[input.captcha] = captcha
            parameters["once"] = input.once
            parameters["next"] = "/member/tospery"
            return .requestParameters(parameters: parameters, encoding: URLEncoding.httpBody)
        case let .userinfo(username):
            parameters["username"] = username
        default:
            return .requestPlain
        }
        return .requestParameters(
            parameters: parameters,
            encoding: URLEncoding.queryString
        )
    }

    var validationType: ValidationType { .none }

    var sampleData: Data { Data.init() }

}
