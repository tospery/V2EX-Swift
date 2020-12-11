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
    
    lazy var termLabel: TTTAttributedLabel = {
        let label = TTTAttributedLabel.init(frame: .zero)
        label.delegate = self
        let text = R.string.localizable.userTerm(
            R.string.localizable.termsOfService(),
            R.string.localizable.privacyAgreement()
        )
        let termCount = R.string.localizable.termsOfService().count
        let privacyCount = R.string.localizable.privacyAgreement().count
        label.setText(
            text.styled(with: .color(.body), .font(.normal(12)))
        )
        label.addLink(
            TTTAttributedLabelLink.init(
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.underlineStyle: NSNumber.init(value: true),
                    NSAttributedString.Key.underlineColor: UIColor.black
                ],
                activeAttributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.red,
                    NSAttributedString.Key.underlineStyle: NSNumber.init(value: true),
                    NSAttributedString.Key.underlineColor: UIColor.red
                ],
                inactiveAttributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.gray,
                    NSAttributedString.Key.underlineStyle: NSNumber.init(value: true),
                    NSAttributedString.Key.underlineColor: UIColor.gray
                ],
                textCheckingResult: .spellCheckingResult(
                    range: .init(
                        location: text.count - termCount - 1 - privacyCount,
                        length: termCount
                    )
                )
            )
        )
        label.addLink(
            TTTAttributedLabelLink.init(
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.underlineStyle: NSNumber.init(value: true),
                    NSAttributedString.Key.underlineColor: UIColor.black
                ],
                activeAttributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.red,
                    NSAttributedString.Key.underlineStyle: NSNumber.init(value: true),
                    NSAttributedString.Key.underlineColor: UIColor.red
                ],
                inactiveAttributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.gray,
                    NSAttributedString.Key.underlineStyle: NSNumber.init(value: true),
                    NSAttributedString.Key.underlineColor: UIColor.gray
                ],
                textCheckingResult: .spellCheckingResult(
                    range: .init(
                        location: text.count - privacyCount,
                        length: privacyCount
                    )
                )
            )
        )
        label.sizeToFit()
        label.height = 20
        return label
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField.init()
        textField.font = .normal(16)
        textField.placeholder = R.string.localizable.username()
        textField.text = "tospery"
        textField.qmui_borderPosition = .bottom
        textField.qmui_borderWidth = 1
        textField.sizeToFit()
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField.init()
        textField.isSecureTextEntry = true
        textField.font = .normal(16)
        textField.text = "v2JX072142"
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
        button.titleLabel?.font = .normal(17)
        button.setTitle(R.string.localizable.getStarted(), for: .normal)
        button.sizeToFit()
        button.height = 44
        button.cornerRadius = button.height / 2.f
        return button
    }()
    
    lazy var weixinButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.borderWidth = 1
        button.contentEdgeInsets = .init(horizontal: metric(20), vertical: metric(20))
        button.setImage(R.image.weixin(), for: .normal)
        button.sizeToFit()
        button.size = .init(metric(60))
        button.cornerRadius = button.height / 2.f
        return button
    }()
    
    init(_ navigator: NavigatorType, _ reactor: LoginViewReactor) {
        defer {
            self.reactor = reactor
        }
        super.init(navigator, reactor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // navbar
        self.navigationBar.transparet()
        self.scrollView.frame = self.contentFrame
        // view
        self.setupView()
        // theme
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
                self.passwordTextField.rx.qmui_borderColor,
                self.weixinButton.rx.borderColor
            ])
            .disposed(by: self.rx.disposeBag)
    }
    
    func setupView() {
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
        // weixin
        self.scrollView.addSubview(self.weixinButton)
        self.weixinButton.left = self.weixinButton.leftWhenCenter
        self.weixinButton.top = flat(self.weixinButton.topWhenCenter * 1.5)
        // term
        self.scrollView.addSubview(self.termLabel)
        self.termLabel.left = self.termLabel.leftWhenCenter
        self.termLabel.bottom = self.scrollView.height - safeBottom - 4
    }

}

extension LoginViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith result: NSTextCheckingResult!) {
        guard let text = label.text as? String else { return }
        let string = (text as NSString).substring(with: result.range)
        switch string {
        case R.string.localizable.termsOfService():
            self.navigator.push(Router.Web.agreement.urlString)
        case R.string.localizable.privacyAgreement():
            self.navigator.push(Router.Web.privacy.urlString)
        default:
            break
        }
    }
}
