//
//  SiteInfo.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

struct SiteInfo: ModelType, Identifiable, Subjective {
    
    var id = ""
    var title = ""
    var slogan = ""
    var domain = ""
    var description = ""
    
    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id              <- map["id"]
        title           <- map["title"]
        slogan          <- map["slogan"]
        domain          <- map["domain"]
        description     <- map["description"]
    }
    
}
