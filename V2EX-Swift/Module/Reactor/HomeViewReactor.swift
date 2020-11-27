//
//  HomeViewReactor.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

class HomeViewReactor: CollectionViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
    }

    enum Mutation {
        case setLoading(Bool)
        case setError(Error?)
        case setTitle(String?)
        case setUser(User?)
    }

    struct State {
        var isLoading = false
        var error: Error?
        var title: String?
        var user: User?
    }

    var initialState = State()

    required init(_ provider: ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: stringDefault(self.title, "收的")
        )
    }

}
