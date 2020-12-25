//
//  TopicListViewReactor.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/12/12.
//

import Foundation

class TopicListViewReactor: CollectionViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
    }

    enum Mutation {
        case setLoading(Bool)
        case setError(Error?)
        case setTitle(String?)
        case setUser(User?)
        case setTopics([Topic])
    }

    struct State {
        var isLoading = false
        var error: Error?
        var title: String?
        var user: User?
        var topics = [Topic].init()
        var sections = [Section].init()
    }

    var node: Node!
    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.node = self.parameters[Parameter.model] as? Node
        self.initialState = State(
            title: self.title ?? R.string.localizable.mine()
        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return Observable.concat([
                .just(.setError(nil)),
                .just(.setLoading(true)),
                self.provider.topics(nodeid: self.node.id).asObservable().map(Mutation.setTopics),
                .just(.setLoading(false))
            ]).catchError({
                Observable.concat([
                    .just(.setLoading(false)),
                    .just(.setError($0))
                ])
            })
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setError(error):
            newState.error = error
        case let .setTitle(title):
            newState.title = title
        case let .setUser(user):
            newState.user = user
        case let .setTopics(topics):
            newState.topics = topics
            let items = topics.map { topic -> TopicItem in
                TopicItem.init(topic)
            }
            let sectionItems = items.map { item -> SectionItem in
                SectionItem.topic(item)
            }
            newState.sections = [.topics(header: "", items: sectionItems)]
        }
        return newState
    }
    
    func transform(action: Observable<Action>) -> Observable<Action> {
        action
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let user = Subjection.for(User.self).asObservable().map(Mutation.setUser)
        return .merge(mutation, user)
    }
    
    func transform(state: Observable<State>) -> Observable<State> {
        state
    }

}
