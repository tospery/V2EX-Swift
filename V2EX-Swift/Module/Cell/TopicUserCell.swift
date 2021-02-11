//
//  TopicUserCell.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2021/2/11.
//

import UIKit

class TopicUserCell: CollectionCell, ReactorKit.View {

    lazy var nameLabel: SWLabel = {
        let label = SWLabel()
        label.font = .normal(13)
        label.sizeToFit()
        label.height = flat(label.font.lineHeight)
        return label
    }()
    
    lazy var timeLabel: SWLabel = {
        let label = SWLabel()
        label.font = .normal(10)
        label.sizeToFit()
        label.height = flat(label.font.lineHeight)
        return label
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.sizeToFit()
        imageView.size = .init(32)
        imageView.cornerRadius = imageView.width / 2.f
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.avatarImageView)
        
        themeService.rx
            .bind({ $0.titleColor }, to: self.nameLabel.rx.textColor)
            .bind({ $0.captionColor }, to: self.timeLabel.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.timeLabel.text = nil
        self.avatarImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin = 20.f
        // let width = self.contentView.width - margin * 2
        self.avatarImageView.left = margin
        self.avatarImageView.top = self.avatarImageView.topWhenCenter
        self.nameLabel.sizeToFit()
        self.nameLabel.left = self.avatarImageView.right + 8
        self.nameLabel.bottom = self.contentView.height / 2.f + 4
        self.timeLabel.sizeToFit()
        self.timeLabel.left = self.nameLabel.left
        self.timeLabel.top = self.nameLabel.bottom
    }

    func bind(reactor: TopicUserItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: self.nameLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.time }
            .distinctUntilChanged()
            .bind(to: self.timeLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.avatar }
            .distinctUntilChanged({ (left, right) -> Bool in
                compare(left, right)
            })
            .bind(to: self.avatarImageView.rx.source)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: 50)
    }

}
