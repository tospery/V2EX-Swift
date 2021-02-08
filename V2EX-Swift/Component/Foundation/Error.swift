//
//  Error.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum APPError: Error {
    case invalidFormat
    case loginFailure(String?)
}

extension APPError: CustomNSError {
    var errorCode: Int {
        switch self {
        case .invalidFormat: return 1
        case .loginFailure: return 2
        }
    }
}

extension APPError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidFormat: return R.string.localizable.errorInvalidFormat()
        case let .loginFailure(message): return message ?? R.string.localizable.errorLogin()
        }
    }
}

extension Error {
    var asSWError: SWError {
        if let app = self as? SWError {
            return app
        }
        
        if let xy = self as? APPError {
            return .app(xy.errorCode, xy.errorDescription)
        }
        
        if let af = self as? AFError {
            switch af {
            case .sessionTaskFailed:
                return .networkUnreachable
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
                        return .networkUnreachable
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
        
        return .app(0, self.localizedDescription)
    }
}
