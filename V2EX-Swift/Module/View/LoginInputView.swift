//
//  LoginInputView.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/29.
//

import UIKit

class LoginInputView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.sizeToFit()
        return imageView
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField.init()
        textField.font = .normal(15)
        textField.sizeToFit()
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cornerRadius = 4
        self.borderWidth = 1
        self.addSubview(self.imageView)
        self.addSubview(self.textField)
        themeService.rx
            .bind({ $0.separatorColor }, to: self.rx.borderColor)
            .bind({ $0.backgroundColor }, to: [
                self.imageView.rx.tintColor,
                self.textField.rx.textColor
            ])
            .disposed(by: self.rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = UIScreen.width - metric(50) * 2
        let height = metric(44)
        return .init(width: width, height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.height = flat(self.height - 8 * 2)
        self.imageView.width = self.imageView.height
        self.imageView.left = 10
        self.imageView.top = self.imageView.topWhenCenter
        self.textField.height = self.height
        self.textField.width = self.width - self.imageView.right - 10 - 8
        self.textField.left = self.imageView.right + 8
        self.textField.top = 0
    }
    
}
