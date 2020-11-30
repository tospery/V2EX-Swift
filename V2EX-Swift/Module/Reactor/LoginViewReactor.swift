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
    }

    enum Mutation {
        case setLoading(Bool)
        case setError(Error?)
        case setTitle(String?)
        case setUser(User?)
        case setCaptchaImage(UIImage?)
    }

    struct State {
        var isLoading = false
        var error: Error?
        var title: String?
        var user: User?
        var captchaImage: UIImage?
        var sections = [Section].init()
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
                self.provider.captcha().asObservable().map(Mutation.setCaptchaImage)
            ]).catchError({
                .just(.setError($0))
            })
        case .login:
            return .empty()
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
        case let .setCaptchaImage(captchaImage):
            newState.captchaImage = captchaImage
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
