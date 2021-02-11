//
//  Section.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum Section {
//    case simples(header: String, items: [SectionItem])
//    case topics(header: String, items: [SectionItem])
//    case topicTitles(header: String, items: [SectionItem])
//    case topicUsers(header: String, items: [SectionItem])
    case sectionItems(header: String, items: [SectionItem])
}

extension Section: AnimatableSectionModelType {
    
    var identity: String {
//        switch self {
//        case let .simples(header, _): return header
//        case let .topics(header, _): return header
//        case let .topicTitles(header, _): return header
//        case let .topicUsers(header, _): return header
//        }
        switch self {
        case let .sectionItems(header, _): return header // YJX_TODO header作为identity其实并不合适
        }
    }

    var items: [SectionItem] {
//        switch self {
//        case let .simples(_, items): return items
//        case let .topics(_, items): return items
//        case let .topicTitles(_, items): return items
//        case let .topicUsers(_, items): return items
//        }
        switch self {
        case let .sectionItems(_, items): return items
        }
    }

    init(original: Section, items: [SectionItem]) {
//        switch original {
//        case let .simples(header, _):
//            self = .simples(header: header, items: items)
//        case let .topics(header, _):
//            self = .topics(header: header, items: items)
//        case let .topicTitles(header, _):
//            self = .topicTitles(header: header, items: items)
//        case let .topicUsers(header, _):
//            self = .topicUsers(header: header, items: items)
//        }
        switch original {
        case let .sectionItems(header, _):
            self = .sectionItems(header: header, items: items)
        }
    }
    
}

enum SectionItem: IdentifiableType, Equatable {
    case simple(SimpleItem)
    case topic(TopicItem)
    case topicTitle(TopicTitleItem)
    case topicUser(TopicUserItem)

    var identity: String {
        switch self {
        case let .simple(item):
            return item.description
        case let .topic(item):
            return item.description
        case let .topicTitle(item):
            return item.description
        case let .topicUser(item):
            return item.description
        }
    }

    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        switch (lhs, rhs) {
        case let (.simple(left), .simple(right)):
            return left.description == right.description
        case let (.topic(left), .topic(right)):
            return left.description == right.description
        case let (.topicTitle(left), .topicTitle(right)):
            return left.description == right.description
        case let (.topicUser(left), .topicUser(right)):
            return left.description == right.description
        default:
            return false
        }
    }
    
}
