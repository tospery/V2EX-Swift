//
//  TopicItem.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/12/13.
//

import Foundation

class TopicItem: CollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction
    typealias Mutation = NoMutation

//    enum Mutation {
//        case setTitle(String?)
//        case setContent(String?)
//    }

    struct State {
        var replies = 0
        var title: String?
        var content: String?
        var username: String?
        var icon: ImageSource?
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
        guard let topic = model as? Topic else { return }
        self.initialState = State(
            replies: topic.replies,
            title: topic.title,
            content: topic.content,
            username: topic.member.username,
            icon: topic.member.avatar.url
        )
    }

//    func reduce(state: State, mutation: Mutation) -> State {
//        var newState = state
//        switch mutation {
//        case let .setTitle(title):
//            newState.title = title
//        }
//        return newState
//    }
    
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
