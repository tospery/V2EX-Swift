//
//  Networking.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

struct Networking: NetworkingType {

    typealias Target = MultiTarget
    let provider: MoyaProvider<MultiTarget>
    
//    static var stubClosure: MoyaProvider<Target>.StubClosure {
//        return { _ in
//            return .delayed(seconds: 3)
//        }
//    }
    
    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        let logger = NetworkLoggerPlugin.init()
        logger.configuration.logOptions = [.requestBody, .successResponseBody, .errorResponseBody]
        logger.configuration.output = output
        plugins.append(logger)
        return plugins
    }
    
    static func output(target: TargetType, items: [String]) {
        for item in items {
            log(item)
        }
    }
    
}
