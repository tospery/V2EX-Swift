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

extension APPError: SWCompatibleError {
    public var swError: SWError {
        .app(self.errorCode, self.errorDescription)
    }
}
