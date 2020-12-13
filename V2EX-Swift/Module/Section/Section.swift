//
//  Section.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum Section {
    case simples(header: String, items: [SectionItem])
    case topics(header: String, items: [SectionItem])
}

extension Section: AnimatableSectionModelType {
    
    var identity: String {
        switch self {
        case let .simples(header, _): return header
        case let .topics(header, _): return header
        }
    }

    var items: [SectionItem] {
        switch self {
        case let .simples(_, items): return items
        case let .topics(_, items): return items
        }
    }

    init(original: Section, items: [SectionItem]) {
        switch original {
        case let .simples(header, _):
            self = .simples(header: header, items: items)
        case let .topics(header, _):
            self = .topics(header: header, items: items)
        }
    }
    
}

enum SectionItem: IdentifiableType, Equatable {
    case simple(SimpleItem)
    case topic(TopicItem)

    var identity: String {
        switch self {
        case let .simple(item):
            return item.description
        case let .topic(item):
            return item.description
        }
    }

    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        switch (lhs, rhs) {
        case let (.simple(left), .simple(right)):
            return left.description == right.description
        case let (.topic(left), .topic(right)):
            return left.description == right.description
        default:
            return false
        }
    }
    
}
