//
//  TopicItem.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/12/13.
//

import Foundation

class TopicItem: CollectionItem, ReactorKit.Reactor {

    typealias Action = NoAction

    enum Mutation {
        case setTitle(String?)
    }

    struct State {
        var icon: ImageSource?
        var title: String?
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setTitle(title):
            newState.title = title
        }
        return newState
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
