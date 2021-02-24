//
//  ArticleItem.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2021/2/11.
//

import Foundation

class ArticleItem: CollectionItem, ReactorKit.Reactor {

//    typealias Action = NoAction
//    typealias Mutation = NoMutation
    
    enum Action {
        case height(CGFloat)
    }

    enum Mutation {
        case setHeight(CGFloat)
    }

    struct State {
        var height = 0.f
        var html = ""
    }

    var initialState = State()

    required init(_ model: ModelType) {
        super.init(model)
        guard let topic = model as? Topic else { return }
        self.initialState = State(
            html: topic.contentRendered
        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .height(height):
            return .just(.setHeight(height))
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setHeight(height):
            newState.height = height
        }
        return newState
    }
    
//    func transform(action: Observable<NoAction>) -> Observable<NoAction> {
//        action
//    }
    
//    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
//        mutation
//    }

    func transform(state: Observable<State>) -> Observable<State> {
        state
    }

}
