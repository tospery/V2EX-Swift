//
//  TopicTitleItem.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2021/2/11.
//

import Foundation

class TopicTitleItem: CollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

    struct State {
        var title: String?
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
        guard let topic = model as? Topic else { return }
        self.initialState = State(
            title: topic.title
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
