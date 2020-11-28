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
    case captcha(once: String)
}

extension V2EXAPI: TargetType {

    var baseURL: URL {
        return UIApplication.shared.baseApiUrl.url!
    }

    var path: String {
        switch self {
        case .siteInfo: return "/api/site/info.json"
        case .signin: return "/signin"
        case .captcha: return "/_captcha"
        }
    }

    var method: Moya.Method { .get }

    var headers: [String: String]? { nil }

    var task: Task {
        var parameters = [String: Any]()
        switch self {
        case let .captcha(once):
            parameters["once"] = once
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
