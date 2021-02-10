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

func compare(_ left: ImageSource?, _ right: ImageSource?) -> Bool {
    if let lImage = left as? UIImage,
       let rImage = right as? UIImage {
        return lImage == rImage
    }
    if let lURL = left as? URL,
       let rURL = right as? URL {
        return lURL == rURL
    }
    return false
}
