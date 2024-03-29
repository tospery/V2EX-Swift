//
//  Node.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/12/12.
//

import Foundation

struct Node: ModelType, Identifiable, Subjective, Eventable {
    
    enum Event {
    }
    
    var id = 0
    var root = false
    var stars = 0
    var topics = 0
    var name = ""
    var title = ""
    var header = ""
    var footer = ""
    var titleAlternative = ""
    var parentNodeName = ""
    var url = ""
    var avatar = ""
    var avatarMini = ""
    var avatarLarge = ""
    var aliases = [String].init()
    
    init() {
    }

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        id                      <- map["id"]
        root                    <- map["root"]
        stars                   <- map["stars"]
        topics                  <- map["topics"]
        name                    <- map["name"]
        title                   <- map["title"]
        header                  <- map["header"]
        footer                  <- map["footer"]
        titleAlternative        <- map["title_alternative"]
        parentNodeName          <- map["parent_node_name"]
        url                     <- map["url"]
        avatar                  <- map["avatar_normal"]
        avatarMini              <- map["avatar_mini"]
        avatarLarge             <- map["avatar_large"]
        aliases                 <- map["aliases"]
    }
    
    static func cachedArray(page: String? = nil) -> [Self]? {
        let key = self.arrayKey(page: page)
        if let array = try? archiver.transformCodable(ofType: [Self].self).object(forKey: key) {
            return array
        }
        if let path = Bundle.main.path(forResource: key, ofType: "json"),
            let json = try? String(contentsOfFile: path, encoding: .utf8) {
            return [Self](JSONString: json)
        }
        if let json = String.init(data: V2EXAPI.hot.sampleData, encoding: .utf8),
           let nodes = [Topic].init(JSONString: json).map({ $0.map { $0.node } }),
           nodes.count != 0 {
            return nodes
        }
        return nil
    }
    
}
