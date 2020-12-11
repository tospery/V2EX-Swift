//
//  User.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

struct User: ModelType, Identifiable, Subjective, Eventable {
    
    enum Event {
    }
    
    var id = ""
    var avatar: String?
    var signature: String?
    
    var username: String {
        return self.id
    }
    
    var isLogined: Bool {
        return !self.id.isEmpty
    }
    
    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id                  <- map["id"]
        avatar              <- map["avatar"]
        signature           <- map["signature"]
    }
    
    static func update(_ user: User?) {
        if let old = Self.current {
            if let new = user {
                if let oldJSONString = old.toJSONString(),
                   let newJSONString = new.toJSONString(),
                   oldJSONString != newJSONString {
                    // 更新
                    log("用户更新: \(new)")
                    new.save(ignoreId: true)
                    Subjection.for(Self.self).accept(new)
                }
            } else {
                // 退出
                log("用户退出: \(old)")
                Self.eraseObject()
                Subjection.for(Self.self).accept(nil)
            }
        } else {
            if let new = user {
                // 登录
                log("用户登录: \(new)")
                new.save(ignoreId: true)
                Subjection.for(Self.self).accept(new)
            }
        }
    }
    
}
