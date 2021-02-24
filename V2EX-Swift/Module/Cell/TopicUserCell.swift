//
//  TopicUserCell.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2021/2/11.
//

import UIKit

class TopicUserCell: CollectionCell, ReactorKit.View {

    lazy var titleLabel: SWLabel = {
        let label = SWLabel()
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.sizeToFit()
        imageView.size = .init(36)
        imageView.cornerRadius = imageView.width / 2.f
        return imageView
    }()
    
    lazy var followButton: SWButton = {
        let button = SWButton.init(type: .custom)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitle(R.string.localizable.follow(), for: .normal)
        button.sizeToFit()
        button.size = .init(width: 72, height: 26)
        button.cornerRadius = button.size.height / 2.f
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.followButton)
        themeService.rx
            .bind({ $0.backgroundColor }, to: self.followButton.rx.titleColor(for: .normal))
            .bind({
                $0.primaryColor.image(size: self.followButton.size)
            }, to: self.followButton.rx.backgroundImage(for: .normal))
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.attributedText = nil
        self.avatarImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.left = 20
        self.avatarImageView.top = self.avatarImageView.topWhenCenter
        self.titleLabel.sizeToFit()
        self.titleLabel.left = self.avatarImageView.right + 8
        self.titleLabel.centerY = self.avatarImageView.centerY
        self.followButton.right = self.contentView.width - 20
        self.followButton.centerY = self.contentView.centerY
    }

    func bind(reactor: TopicUserItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.attributedText)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.avatar }
            .distinctUntilChanged({ (left, right) -> Bool in
                compare(left, right)
            })
            .bind(to: self.avatarImageView.rx.imageSource)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: 50)
    }

}
