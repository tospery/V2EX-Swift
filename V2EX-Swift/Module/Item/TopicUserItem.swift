//
//  TopicUserItem.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2021/2/11.
//

import Foundation

class TopicUserItem: CollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var title: NSAttributedString?
        var avatar: URL?
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
        guard let topic = model as? Topic else { return }
        self.initialState = State(
            title: NSAttributedString.composed(of: [
                topic.member.username
                    .styled(with: .font(.systemFont(ofSize: 14)), .color(.title)),
                Special.nextLine,
                Date.init(timeIntervalSince1970: topic.lastModified)
                    .string(withFormat: "yyyy-MM-dd HH:mm")
                    .styled(with: .font(.systemFont(ofSize: 12)), .color(.caption))
            ]).styled(with: .lineSpacing(1)),
            avatar: topic.member.avatar.url
        )
    }

    func transform(action: Observable<NoAction>) -> Observable<NoAction> {
        action
    }

    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        mutation
    }

    func transform(state: Observable<State>) -> Observable<State> {
        state
    }

}
