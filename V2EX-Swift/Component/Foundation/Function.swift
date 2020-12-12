//
//  Function.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

func update<T: Subjective>(_ type: T.Type, _ value: T?) {
    if let value = value {
        value.save(ignoreId: true)
    } else {
        T.eraseObject()
    }
    Subjection.for(type).accept(value)
}
