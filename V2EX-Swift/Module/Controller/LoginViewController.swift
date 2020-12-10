//
//  LoginViewController.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class LoginViewController: ScrollViewController, ReactorKit.View {
    
    lazy var sloganLabel: UILabel = {
        let label = UILabel.init()
        label.font = .normal(18)
        label.textAlignment = .center
        label.text = R.string.localizable.slogan()
        label.sizeToFit()
        return label
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField.init()
        textField.font = .normal(16)
        textField.placeholder = R.string.localizable.username()
        textField.qmui_borderPosition = .bottom
        textField.qmui_borderWidth = 1
        textField.sizeToFit()
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField.init()
        textField.font = .normal(16)
        textField.placeholder = R.string.localizable.password()
        textField.qmui_borderPosition = .bottom
        textField.qmui_borderWidth = 1
        textField.sizeToFit()
        return textField
    }()
    
    lazy var captchaView: LoginCaptchaView = {
        let view = LoginCaptchaView.init()
        view.sizeToFit()
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = R.image.app_icon()
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.isEnabled = false
        button.titleLabel?.font = .normal(17)
        button.setTitle(R.string.localizable.getStarted(), for: .normal)
        button.sizeToFit()
        button.height = metric(40)
        button.cornerRadius = button.height / 2.f
        return button
    }()
    
//
//    lazy var accountView: LoginInputView = {
//        let view = LoginInputView.init()
//        view.imageView.image = R.image.login_account()?.template
//        view.textField.placeholder = R.string.localizable.username()
//        view.textField.setPlaceHolderTextColor(.body)
//        view.textField.text = "tospery"
//        view.sizeToFit()
//        return view
//    }()
//
//    lazy var passwordView: LoginInputView = {
//        let view = LoginInputView.init()
//        view.imageView.image = R.image.login_password()?.template
//        view.textField.placeholder = R.string.localizable.password()
//        view.textField.setPlaceHolderTextColor(.body)
//        view.textField.text = "v2JX072142"
//        view.sizeToFit()
//        return view
//    }()
//
//    lazy var captchaView: LoginInputView = {
//        let view = LoginInputView.init()
//        view.imageView.image = R.image.login_captcha()?.template
//        view.textField.placeholder = R.string.localizable.captcha()
//        view.textField.setPlaceHolderTextColor(.body)
//        view.sizeToFit()
//        view.width -= metric(140)
//        return view
//    }()
    
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
        
//        // icon
//        self.scrollView.addSubview(self.iconImageView)
//        self.iconImageView.left = self.iconImageView.leftWhenCenter
//        self.iconImageView.centerY = flat(self.scrollView.height / 2.0 * 0.35)
//        // slogan
//        self.scrollView.addSubview(self.sloganLabel)
//        self.sloganLabel.left = self.sloganLabel.leftWhenCenter
//        self.sloganLabel.top = self.iconImageView.bottom
//        // username
//        let margin = metric(20)
//        let height = metric(50)
//        self.scrollView.addSubview(self.usernameTextField)
//        self.usernameTextField.width = self.scrollView.width - margin * 2
//        self.usernameTextField.height = height
//        self.usernameTextField.left = self.usernameTextField.leftWhenCenter
        
//        // captcha
//        let margin = metric(20)
//        let height = metric(50)
//        self.scrollView.addSubview(self.captchaView)
//        self.captchaView.width = self.scrollView.width - margin * 2
//        self.captchaView.height = height
//        self.captchaView.left = self.captchaView.leftWhenCenter
//        self.captchaView.top = self.captchaView.topWhenCenter
        
//        // password
//        let margin = metric(20)
//        let height = 50.f
//        let width = self.scrollView.width - margin * 2
//        self.scrollView.addSubview(self.passwordTextField)
//        self.passwordTextField.width = width
//        self.passwordTextField.height = height
//        self.passwordTextField.left = self.passwordTextField.leftWhenCenter
//        self.passwordTextField.top = self.passwordTextField.topWhenCenter
        
        // captcha
        let margin = metric(20)
        let height = 44.f
        let width = self.scrollView.width - margin * 2
        self.scrollView.addSubview(self.captchaView)
        self.captchaView.width = width
        self.captchaView.height = height
        self.captchaView.left = self.captchaView.leftWhenCenter
        self.captchaView.top = self.captchaView.topWhenCenter
        // password
        self.scrollView.addSubview(self.passwordTextField)
        self.passwordTextField.width = width
        self.passwordTextField.height = height
        self.passwordTextField.left = self.passwordTextField.leftWhenCenter
        self.passwordTextField.bottom = self.captchaView.top - 8
        // username
        self.scrollView.addSubview(self.usernameTextField)
        self.usernameTextField.width = width
        self.usernameTextField.height = height
        self.usernameTextField.left = self.usernameTextField.leftWhenCenter
        self.usernameTextField.bottom = self.passwordTextField.top - 8
        // slogan
        self.scrollView.addSubview(self.sloganLabel)
        self.sloganLabel.left = self.sloganLabel.leftWhenCenter
        self.sloganLabel.bottom = self.usernameTextField.top - metric(40)
        // icon
        self.scrollView.addSubview(self.iconImageView)
        self.iconImageView.left = self.iconImageView.leftWhenCenter
        self.iconImageView.bottom = self.sloganLabel.top
        // login
        self.scrollView.addSubview(self.loginButton)
        self.loginButton.width = width
        self.loginButton.left = self.loginButton.leftWhenCenter
        self.loginButton.top = self.captchaView.bottom + 30
        
        let size = self.loginButton.size
        themeService.rx
            .bind({ $0.titleColor }, to: self.sloganLabel.rx.textColor)
            .bind({ $0.primaryColor.image(size: size) },
                  to: self.loginButton.rx.backgroundImage(for: .normal))
            .bind({ $0.primaryColor.withAlphaComponent(0.5).image(size: size) },
                  to: self.loginButton.rx.backgroundImage(for: .disabled))
            .bind({ $0.backgroundColor }, to: self.loginButton.rx.titleColor(for: .normal))
            .bind({ $0.borderColor }, to: [
                self.usernameTextField.rx.qmui_borderColor,
                self.passwordTextField.rx.qmui_borderColor
            ])
            .disposed(by: self.rx.disposeBag)
        
//        self.scrollView.addSubview(self.backgroundImageView)
//        self.backgroundImageView.frame = self.scrollView.bounds
//        self.scrollView.addSubview(self.frostedView)
//        self.frostedView.frame = self.scrollView.bounds
//        var blurEffect = UIBlurEffect.Style.dark
//        if #available(iOS 13.0, *) {
//            blurEffect = .systemUltraThinMaterialDark
//        }
//        let vibrancyEffect = UIVibrancyEffect.init(blurEffect: UIBlurEffect.init(style: blurEffect))
//        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
//        vibrancyView.isUserInteractionEnabled = true
//        vibrancyView.frame = self.frostedView.frame
//        self.frostedView.contentView.addSubview(vibrancyView)
//        self.scrollView.addSubview(self.accountView)
//        self.scrollView.addSubview(self.passwordView)
//        self.scrollView.addSubview(self.captchaView)
//        self.scrollView.addSubview(self.captchaImageView)
//        self.scrollView.addSubview(self.loginButton)
//
//        self.accountView.left = self.accountView.leftWhenCenter
//        self.accountView.centerY = flat(self.scrollView.height / 2.0 * 0.5)
//        self.passwordView.left = self.accountView.left
//        self.passwordView.top = self.accountView.bottom + 20
//        self.captchaView.left = self.accountView.left
//        self.captchaView.top = self.passwordView.bottom + 20
//        self.captchaImageView.width = self.accountView.width - self.captchaView.width - 2
//        self.captchaImageView.height = self.captchaView.height
//        self.captchaImageView.top = self.captchaView.top
//        self.captchaImageView.left = self.captchaView.right + 2
//        self.loginButton.width = self.accountView.width
//        self.loginButton.height = self.accountView.height
//        self.loginButton.left = self.accountView.left
//        self.loginButton.top = self.captchaView.bottom + 30
        
//        self.loginButton.rx.tap
//            .subscribeNext(weak: self, type(of: self).tapLogin)
//            .disposed(by: self.disposeBag)
        
//        themeService.rx
//            .bind({ $0.backgroundColor }, to: [
//                self.navigationBar.rx.itemColor,
//                self.navigationBar.rx.titleColor,
//                self.loginButton.rx.titleColor(for: .normal),
//                self.loginButton.rx.borderColor
//            ])
//            .disposed(by: self.rx.disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if self.backgroundImageView.alpha == 0 {
//            UIView.animate(withDuration: 2) {
//                self.backgroundImageView.alpha = 1
//            }
//            UIView.animate(withDuration: 20) {
//                self.backgroundImageView.frame = .init(
//                    x: -1 * (1000 - UIScreen.width) / 2,
//                    y: 0,
//                    width: UIScreen.height + 500,
//                    height: UIScreen.height + 500
//                )
//            }
//        }
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
//        reactor.state.map { $0.input?.image }
//            .distinctUntilChanged()
//            .bind(to: self.rx.captchaImage)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.user }
//            .filterNil()
//            .distinctUntilChanged()
//            .subscribeNext(weak: self, type(of: self).handle)
//            .disposed(by: self.disposeBag)
    }
    
//    func handle(_ user: User) {
//        // User.update(user)
//        user.save(ignoreId: true)
//        self.dismiss(animated: true, completion: nil)
//    }
    
}

extension Reactive where Base: LoginViewController {

//    var captchaImage: Binder<UIImage?> {
//        return Binder(self.base) { viewController, image in
//            viewController.captchaImageView.image = image
//        }
//    }

}
