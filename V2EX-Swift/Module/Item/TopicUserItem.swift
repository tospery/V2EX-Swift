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
        var name: String?
        var time: String?
        var avatar: URL?
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
        guard let topic = model as? Topic else { return }
        self.initialState = State(
            name: topic.member.username,
            time: Date.init(timeIntervalSince1970: topic.lastModified).string(withFormat: "yyyy-MM-dd HH:mm"),
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
