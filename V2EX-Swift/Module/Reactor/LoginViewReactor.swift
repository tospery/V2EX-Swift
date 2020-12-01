//
//  LoginViewReactor.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import Foundation

class LoginViewReactor: ScrollViewReactor, ReactorKit.Reactor {

    enum Action {
        case load
        case login
        case username(String?)
        case password(String?)
        case captcha(String?)
    }

    enum Mutation {
        case setLoading(Bool)
        case setError(Error?)
        case setTitle(String?)
        case setUsername(String?)
        case setPassword(String?)
        case setCaptcha(String?)
        case setUser(User?)
        case setInput(Input?)
    }

    struct State {
        var isLoading = false
        var error: Error?
        var title: String?
        var user: User?
        var username: String?
        var password: String?
        var captcha: String?
        var input: Input?
        var sections = [Section].init()
    }
    
    struct Input {
        let username: String
        let password: String
        let captcha: String
        let once: String
        let image: UIImage
    }

    var initialState = State()

    required init(_ provider: SWFrame.ProviderType, _ parameters: [String: Any]?) {
        super.init(provider, parameters)
        self.initialState = State(
            title: stringDefault(self.title, R.string.localizable.login())
        )
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return Observable.concat([
                .just(.setError(nil)),
                self.provider.captcha().asObservable().map(Mutation.setInput)
            ]).catchError({
                .just(.setError($0))
            })
        case let .username(username):
            return .just(.setUsername(username))
        case let .password(password):
            return .just(.setPassword(password))
        case let .captcha(captcha):
            return .just(.setCaptcha(captcha))
        case .login:
            guard
                let username = self.currentState.username,
                let password = self.currentState.password,
                let captcha = self.currentState.captcha,
                let input = self.currentState.input
            else {
                return .empty()
            }
            return Observable.concat([
                .just(.setError(nil)),
                self.provider.login(
                    username: username,
                    password: password,
                    captcha: captcha,
                    input: input
                )
                .asObservable()
                .map(Mutation.setUser)
            ]).catchError({
                .just(.setError($0))
            })
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setError(error):
            if error != nil && state.isLoading {
                newState.isLoading = false
            }
            newState.error = error
        case let .setTitle(title):
            newState.title = title
        case let .setUser(user):
            newState.user = user
        case let .setUsername(username):
            newState.username = username
        case let .setPassword(password):
            newState.password = password
        case let .setCaptcha(captcha):
            newState.captcha = captcha
        case let .setInput(input):
            newState.input = input
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
