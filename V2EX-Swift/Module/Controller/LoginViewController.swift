//
//  LoginViewController.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class LoginViewController: ScrollViewController, ReactorKit.View {
    
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
    
    lazy var accountView: LoginInputView = {
        let view = LoginInputView.init()
        view.sizeToFit()
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
        themeService.rx
            .bind({ $0.backgroundColor }, to: [
                self.navigationBar.rx.itemColor,
                self.navigationBar.rx.titleColor
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
        self.accountView.left = self.accountView.leftWhenCenter
        self.accountView.centerY = flat(self.scrollView.height / 2.0 * 0.5)
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
        // state
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.navigationBar.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.rx.loading())
            .disposed(by: self.disposeBag)
    }

}
