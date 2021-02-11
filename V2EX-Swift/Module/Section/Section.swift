//
//  Section.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

enum Section {
    case sectionItems(header: String, items: [SectionItem])
}

extension Section: AnimatableSectionModelType {
    
    var identity: String {
        switch self {
        case let .sectionItems(header, _): return header // YJX_TODO header作为identity其实并不合适
        }
    }

    var items: [SectionItem] {
        switch self {
        case let .sectionItems(_, items): return items
        }
    }

    init(original: Section, items: [SectionItem]) {
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
    case article(ArticleItem)

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
        case let .article(item):
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
        case let (.article(left), .article(right)):
            return left.description == right.description
        default:
            return false
        }
    }
    
}
