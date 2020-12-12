//
//  LoginViewControllerExt.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/12/11.
//

import UIKit

extension LoginViewController {
    
    func bind(reactor: LoginViewReactor) {
        super.bind(reactor: reactor)
        // action
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load },
            self.captchaView.imageView.rx.tapGesture().skip(1).map { _ in Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        self.usernameTextField.rx.text
            .map { Reactor.Action.username($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        self.passwordTextField.rx.text
            .map { Reactor.Action.password($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        self.captchaView.textField.rx.text
            .map { Reactor.Action.captcha($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        self.loginButton.rx.tap.map { Reactor.Action.login }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        // state
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.loading())
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.input?.image }
            .distinctUntilChanged()
            .bind(to: self.rx.captchaImage)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isCaptchaing }
            .distinctUntilChanged()
            .bind(to: self.rx.captchaing)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.error }
            .distinctUntilChanged({ $0?.asAPPError == $1?.asAPPError })
            .bind(to: self.rx.error)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.user }
            .distinctUntilChanged()
            .skip(1)
            .filterNil()
            .subscribeNext(weak: self, type(of: self).handle)
            .disposed(by: self.disposeBag)
        Observable.combineLatest(
            reactor.state.map { $0.username }.distinctUntilChanged(),
            reactor.state.map { $0.password }.distinctUntilChanged(),
            reactor.state.map { $0.captcha }.distinctUntilChanged()
        )
        .map { $0?.isNotEmpty ?? false && $1?.isNotEmpty ?? false && $2?.isNotEmpty ?? false }
        .distinctUntilChanged()
        .bind(to: self.loginButton.rx.isEnabled).disposed(by: self.disposeBag)
    }
    
    func handle(user: User) {
        User.update(user)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension Reactive where Base: LoginViewController {

    var error: Binder<Error?> {
        return Binder(self.base) { viewController, error in
            viewController.error = error
            viewController.errorLabel.text = error?.localizedDescription
        }
    }
    
    var captchaing: Binder<Bool> {
        return Binder(self.base) { viewController, isCaptchaing in
            if isCaptchaing {
                viewController.captchaView.imageView.image = R.image.captcha_loading()
            } else {
                if viewController.reactor?.currentState.input?.image == nil {
                    viewController.captchaView.imageView.image = R.image.captcha_failed()
                }
            }
        }
    }
    
    var captchaImage: Binder<UIImage?> {
        return Binder(self.base) { viewController, image in
            guard let isCaptchaing = viewController.reactor?.currentState.isCaptchaing else { return }
            if isCaptchaing {
                viewController.captchaView.imageView.image = image
            }
        }
    }

}
