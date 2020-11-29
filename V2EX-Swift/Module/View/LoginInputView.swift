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
        imageView.image = R.image.login_account()
        imageView.sizeToFit()
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cornerRadius = 4
        self.borderWidth = 1
        self.addSubview(self.imageView)
        themeService.rx
            .bind({ $0.separatorColor }, to: self.rx.borderColor)
            .disposed(by: self.rx.disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = UIScreen.width - metric(50) * 2
        let height = metric(40)
        return .init(width: width, height: height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.height = self.height
        self.imageView.width = self.imageView.height
        self.imageView.left = 0
        self.imageView.top = 0
    }
    
}
