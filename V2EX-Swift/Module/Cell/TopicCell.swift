//
//  TopicCell.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/12/13.
//

import UIKit

class TopicCell: CollectionCell, ReactorKit.View {

    lazy var usernameLabel: SWLabel = {
        let label = SWLabel()
        label.font = .systemFont(ofSize: 12)
        label.sizeToFit()
        label.height = flat(label.font.lineHeight)
        return label
    }()
    
    lazy var repliesLabel: SWLabel = {
        let label = SWLabel()
        label.font = .systemFont(ofSize: 12)
        label.sizeToFit()
        label.height = flat(label.font.lineHeight)
        return label
    }()
    
    lazy var titleLabel: SWLabel = {
        let label = SWLabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = .boldSystemFont(ofSize: 16)
        label.sizeToFit()
        label.height = flat(label.font.lineHeight)
        return label
    }()
    
    lazy var contentLabel: SWLabel = {
        let label = SWLabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()

    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.sizeToFit()
        imageView.size = .init(16)
        imageView.cornerRadius = imageView.width / 2.f
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderLayer?.borders = .bottom
        self.borderLayer?.borderColors = [BorderLayer.Border.bottom: UIColor.border]
        self.borderLayer?.borderWidths = [BorderLayer.Border.bottom: 1]
        self.borderLayer?.borderInsets = [BorderLayer.Border.bottom: (10, 10)]
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.usernameLabel)
        self.contentView.addSubview(self.repliesLabel)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.avatarImageView)
        
        themeService.rx
            .bind({ $0.titleColor }, to: self.titleLabel.rx.textColor)
            .bind({ $0.bodyColor }, to: self.contentLabel.rx.textColor)
            .bind({ $0.captionColor }, to: [
                self.usernameLabel.rx.textColor,
                self.repliesLabel.rx.textColor
            ])
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.contentLabel.text = nil
        self.usernameLabel.text = nil
        self.repliesLabel.text = nil
        self.avatarImageView.image = nil
    }
    
    override class var layerClass: AnyClass {
        return BorderLayer.self
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.layer.frame.size = self.bounds.size
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let margin = 20.f
        let width = self.contentView.width - margin * 2
        self.titleLabel.width = width
        self.titleLabel.left = margin
        self.titleLabel.top = 10
        self.avatarImageView.left = margin
        self.avatarImageView.bottom = self.contentView.height - 8
        self.usernameLabel.sizeToFit()
        self.usernameLabel.left = self.avatarImageView.right + 4
        self.usernameLabel.centerY = self.avatarImageView.centerY
        self.repliesLabel.sizeToFit()
        self.repliesLabel.right = self.contentView.width - margin
        self.repliesLabel.centerY = self.avatarImageView.centerY
        self.contentLabel.sizeToFit()
        self.contentLabel.width = width
        self.contentLabel.left = margin
        self.contentLabel.top = self.titleLabel.bottom + 4
        self.contentLabel.height = self.avatarImageView.top - self.contentLabel.top - 4
    }

    func bind(reactor: TopicItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.content }
            .distinctUntilChanged()
            .bind(to: self.contentLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.username }
            .distinctUntilChanged()
            .bind(to: self.usernameLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { "\($0.replies)评论" }
            .distinctUntilChanged()
            .bind(to: self.repliesLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { $0.icon }
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
        return CGSize(width: width, height: 100)
    }

}
