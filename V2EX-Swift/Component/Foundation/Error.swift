//
//  Error.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum V2EXError: Error {
    case invalidFormat
}

extension V2EXError: CustomNSError {
    var errorCode: Int {
        switch self {
        case .invalidFormat: return 1
        }
    }
}

extension V2EXError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidFormat: return R.string.localizable.errorInvalidFormat()
        }
    }
}

extension Error {
    var asAPPError: APPError {
        if let app = self as? APPError {
            return app
        }
        
        if let v2ex = self as? V2EXError {
            return .illegal(v2ex.errorCode, v2ex.errorDescription)
        }
        
        if let af = self as? AFError {
            switch af {
            case .sessionTaskFailed:
                return .network
            default:
                break
            }
        }
        
        if let my = self as? MoyaError {
            switch my {
            case let .underlying(error, _):
                if let af = error as? AFError {
                    switch af {
                    case .sessionTaskFailed:
                        return .network
                    default:
                        return .server(0, error.localizedDescription)
                    }
                } else {
                    return .server(0, error.localizedDescription)
                }
            default:
                return .server(0, nil)
            }
        }
        
        return .illegal(0, self.localizedDescription)
    }
}
