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
    var token: String?
    var username: String?
    
    var isLogined: Bool {
        if self.id.isEmpty ||
            self.token?.isEmpty ?? true ||
            self.username?.isEmpty ?? true {
            return false
        }
        return true
    }
    
    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id                  <- map["id"]
        token               <- map["token"]
        username            <- map["username"]
    }
    
    static func update(_ user: User?) {
        if let old = Self.current {
            if let new = user {
                if let oldJSONString = old.toJSONString(),
                   let newJSONString = new.toJSONString(),
                   oldJSONString != newJSONString {
                    // 更新
                    new.save(ignoreId: true)
                    Subjection.for(Self.self).accept(new)
                }
            } else {
                // 退出
                Self.eraseObject()
                Subjection.for(Self.self).accept(nil)
            }
        } else {
            if let new = user {
                // 登录
                new.save(ignoreId: true)
                Subjection.for(Self.self).accept(new)
            }
        }
    }
    
}
