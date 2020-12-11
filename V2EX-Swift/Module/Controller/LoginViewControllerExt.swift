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
//        self.accountView.textField.rx.text
//            .map { Reactor.Action.username($0) }
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)
//        self.passwordView.textField.rx.text
//            .map { Reactor.Action.password($0) }
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)
//        self.captchaView.textField.rx.text
//            .map { Reactor.Action.captcha($0) }
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)
//        self.loginButton.rx.tap.map { Reactor.Action.login }
//            .bind(to: reactor.action)
//            .disposed(by: self.disposeBag)
        // state
//        reactor.state.map { $0.title }
//            .distinctUntilChanged()
//            .bind(to: self.navigationBar.titleLabel.rx.text)
//            .disposed(by: self.disposeBag)
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
//        reactor.state.map { $0.user }
//            .filterNil()
//            .distinctUntilChanged()
//            .subscribeNext(weak: self, type(of: self).handle)
//            .disposed(by: self.disposeBag)
    }
    
}

extension Reactive where Base: LoginViewController {

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
