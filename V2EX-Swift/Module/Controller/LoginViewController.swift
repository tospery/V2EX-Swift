//
//  LoginViewController.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class LoginViewController: ScrollViewController, ReactorKit.View {
    
    lazy var loginButton: SWFrame.Button = {
        let button = SWFrame.Button.init(type: .custom)
        button.cornerRadius = 4
        button.borderWidth = 1
        button.titleLabel?.font = .normal(17)
        button.setTitle(R.string.localizable.login(), for: .normal)
        button.sizeToFit()
        return button
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.alpha = 0
        imageView.image = R.image.login_bg()
        imageView.contentMode = .scaleAspectFill
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var frostedView: UIVisualEffectView = {
        let view = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .dark))
        return view
    }()
    
    lazy var captchaImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.cornerRadius = 4
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var accountView: LoginInputView = {
        let view = LoginInputView.init()
        view.imageView.image = R.image.login_account()?.template
        view.textField.placeholder = R.string.localizable.username()
        view.textField.setPlaceHolderTextColor(.body)
        view.textField.text = "tospery"
        view.sizeToFit()
        return view
    }()
    
    lazy var passwordView: LoginInputView = {
        let view = LoginInputView.init()
        view.imageView.image = R.image.login_password()?.template
        view.textField.placeholder = R.string.localizable.password()
        view.textField.setPlaceHolderTextColor(.body)
        view.textField.text = "v2JX072142"
        view.sizeToFit()
        return view
    }()
    
    lazy var captchaView: LoginInputView = {
        let view = LoginInputView.init()
        view.imageView.image = R.image.login_captcha()?.template
        view.textField.placeholder = R.string.localizable.captcha()
        view.textField.setPlaceHolderTextColor(.body)
        view.sizeToFit()
        view.width -= metric(140)
        return view
    }()
    
    init(_ navigator: NavigatorType, _ reactor: LoginViewReactor) {
        defer {
            self.reactor = reactor
        }
        super.init(navigator, reactor)
        // self.hidesNavBottomLine = boolMember(reactor.parameters, Parameter.hideNavLine, true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.transparet()
        self.scrollView.frame = self.contentFrame
        self.scrollView.addSubview(self.backgroundImageView)
        self.backgroundImageView.frame = self.scrollView.bounds
        self.scrollView.addSubview(self.frostedView)
        self.frostedView.frame = self.scrollView.bounds
        var blurEffect = UIBlurEffect.Style.dark
        if #available(iOS 13.0, *) {
            blurEffect = .systemUltraThinMaterialDark
        }
        let vibrancyEffect = UIVibrancyEffect.init(blurEffect: UIBlurEffect.init(style: blurEffect))
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyView.isUserInteractionEnabled = true
        vibrancyView.frame = self.frostedView.frame
        self.frostedView.contentView.addSubview(vibrancyView)
        self.scrollView.addSubview(self.accountView)
        self.scrollView.addSubview(self.passwordView)
        self.scrollView.addSubview(self.captchaView)
        self.scrollView.addSubview(self.captchaImageView)
        self.scrollView.addSubview(self.loginButton)
        
        self.accountView.left = self.accountView.leftWhenCenter
        self.accountView.centerY = flat(self.scrollView.height / 2.0 * 0.5)
        self.passwordView.left = self.accountView.left
        self.passwordView.top = self.accountView.bottom + 20
        self.captchaView.left = self.accountView.left
        self.captchaView.top = self.passwordView.bottom + 20
        self.captchaImageView.width = self.accountView.width - self.captchaView.width - 2
        self.captchaImageView.height = self.captchaView.height
        self.captchaImageView.top = self.captchaView.top
        self.captchaImageView.left = self.captchaView.right + 2
        self.loginButton.width = self.accountView.width
        self.loginButton.height = self.accountView.height
        self.loginButton.left = self.accountView.left
        self.loginButton.top = self.captchaView.bottom + 30
        
//        self.loginButton.rx.tap
//            .subscribeNext(weak: self, type(of: self).tapLogin)
//            .disposed(by: self.disposeBag)
        
        themeService.rx
            .bind({ $0.backgroundColor }, to: [
                self.navigationBar.rx.itemColor,
                self.navigationBar.rx.titleColor,
                self.loginButton.rx.titleColor(for: .normal),
                self.loginButton.rx.borderColor
            ])
            .disposed(by: self.rx.disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.backgroundImageView.alpha == 0 {
            UIView.animate(withDuration: 2) {
                self.backgroundImageView.alpha = 1
            }
            UIView.animate(withDuration: 20) {
                self.backgroundImageView.frame = .init(
                    x: -1 * (1000 - UIScreen.width) / 2,
                    y: 0,
                    width: UIScreen.height + 500,
                    height: UIScreen.height + 500
                )
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func bind(reactor: LoginViewReactor) {
        super.bind(reactor: reactor)
        // action
        Observable.merge([
            self.rx.viewDidLoad.map { Reactor.Action.load },
            self.rx.emptyDataSet.map { Reactor.Action.load }
        ])
        .bind(to: reactor.action)
        .disposed(by: self.disposeBag)
        self.accountView.textField.rx.text
            .map { Reactor.Action.username($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        self.passwordView.textField.rx.text
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
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.navigationBar.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.loading())
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.input?.image }
            .distinctUntilChanged()
            .bind(to: self.rx.captchaImage)
            .disposed(by: self.disposeBag)
    }
    
}

extension Reactive where Base: LoginViewController {

    var captchaImage: Binder<UIImage?> {
        return Binder(self.base) { viewController, image in
            viewController.captchaImageView.image = image
        }
    }

}
