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
    
    var id = 0
    var created: UInt64 = 0
    var username = ""
    var url = ""
    var avatar = ""
    var avatarMini = ""
    var avatarLarge = ""
    var location = ""
    var tagline = ""
    var website = ""
    var twitter = ""
    var github = ""
    var btc = ""
    var psn = ""
    var bio = ""
    
    var isLogined: Bool {
        return self.id != 0
    }
    
    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id                  <- map["id"]
        created             <- map["created"]
        username            <- map["username"]
        url                 <- map["url"]
        avatar              <- map["avatar_normal"]
        avatarMini          <- map["avatar_mini"]
        avatarLarge         <- map["avatar_large"]
        location            <- map["location"]
        tagline             <- map["tagline"]
        website             <- map["website"]
        twitter             <- map["twitter"]
        github              <- map["github"]
        btc                 <- map["btc"]
        psn                 <- map["psn"]
        bio                 <- map["bio"]
    }
    
    static func update(_ user: User?) {
        if let old = Self.current {
            if let new = user {
                if let oldJSONString = old.toJSONString(),
                   let newJSONString = new.toJSONString(),
                   oldJSONString != newJSONString {
                    // 更新
                    log("用户更新: \(new)")
                    V2EX_Swift.update(User.self, new)
                }
            } else {
                // 退出
                log("用户退出: \(old)")
                V2EX_Swift.update(User.self, nil)
            }
        } else {
            if let new = user {
                // 登录
                log("用户登录: \(new)")
                V2EX_Swift.update(User.self, new)
            }
        }
    }
    
}
