//
//  Topic.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/12/12.
//

import Foundation

struct Topic: ModelType, Identifiable, Subjective, Eventable {
    
    enum Event {
    }
    
    var id = 0
    var replies = 0
    var created: TimeInterval = 0
    var lastModified: TimeInterval = 0
    var lastTouched: TimeInterval = 0
    var title = ""
    var content = ""
    var contentRendered = ""
    var lastReplyBy = ""
    var url = ""
    var node = Node.init()
    var member = User.init()
    
    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id                      <- map["id"]
        replies                 <- map["replies"]
        created                 <- map["created"]
        lastModified            <- map["last_modified"]
        lastTouched             <- map["last_touched"]
        title                   <- map["title"]
        content                 <- map["content"]
        contentRendered         <- map["content_rendered"]
        lastReplyBy             <- map["last_reply_by"]
        url                     <- map["url"]
        node                    <- map["node"]
        member                  <- map["member"]
    }
    
}
