//
//  LoginCaptchaView.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/12/11.
//

import UIKit

class LoginCaptchaView: UIView {
    
    lazy var textField: UITextField = {
        let textField = UITextField.init()
        textField.font = .normal(16)
        textField.placeholder = R.string.localizable.captcha()
        textField.qmui_borderPosition = .bottom
        textField.qmui_borderWidth = 1
        textField.sizeToFit()
        return textField
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = R.image.captcha_loading()
        imageView.sizeToFit()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.addSubview(self.textField)
        themeService.rx
            .bind({ $0.titleColor }, to: self.textField.rx.textColor)
            .bind({ $0.borderColor }, to: self.textField.rx.qmui_borderColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        .init(width: UIScreen.width - metric(20) * 2, height: 44)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.height = self.height
        self.imageView.width = flat(self.imageView.height * 2.5)
        self.imageView.top = 0
        self.imageView.right = self.width
        self.textField.width = self.width - self.imageView.width - 8
        self.textField.height = self.height
        self.textField.left = 0
        self.textField.top = 0
    }
    
}
