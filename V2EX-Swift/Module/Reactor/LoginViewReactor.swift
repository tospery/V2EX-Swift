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
        case setCaptchaing(Bool)
        case setError(Error?)
        case setUsername(String?)
        case setPassword(String?)
        case setCaptcha(String?)
        case setUser(User?)
        case setInput(Input?)
    }

    struct State {
        var isLoading = false
        var isCaptchaing = false
        var error: Error?
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
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return self.load()
        case let .username(username):
            return .just(.setUsername(username))
        case let .password(password):
            return .just(.setPassword(password))
        case let .captcha(captcha):
            return .just(.setCaptcha(captcha))
        case .login:
            return self.login()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        case let .setCaptchaing(isCaptchaing):
            newState.isCaptchaing = isCaptchaing
        case let .setError(error):
            newState.error = error
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
        mutation
    }
    
    func transform(state: Observable<State>) -> Observable<State> {
        state
    }
    
    func load() -> Observable<Mutation> {
        return Observable.concat([
            .just(.setError(nil)),
            .just(.setInput(nil)),
            .just(.setCaptchaing(true)),
            self.provider.captcha().asObservable().map(Mutation.setInput),
            .just(.setCaptchaing(false))
        ]).catchError({
            Observable.concat([
                .just(.setCaptchaing(false)),
                .just(.setError($0))
            ])
        })
    }
    
    func login() -> Observable<Mutation> {
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
            .just(.setLoading(true)),
            self.provider.login(
                username: username,
                password: password,
                captcha: captcha,
                input: input
            )
            .asObservable()
            .map(Mutation.setUser),
            .just(.setLoading(false))
        ]).catchError({
            Observable.concat([
                .just(.setLoading(false)),
                .just(.setError($0))
            ])
        })
    }

}
