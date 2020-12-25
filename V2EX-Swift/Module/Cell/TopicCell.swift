//
//  TopicCell.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/12/13.
//

import UIKit

class TopicCell: CollectionCell, ReactorKit.View {

    lazy var titleLabel: SWLabel = {
        let label = SWLabel()
        label.lineBreakMode = .byCharWrapping
        label.font = .bold(16)
        label.sizeToFit()
        label.height = flat(label.font.lineHeight)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderLayer?.borders = .bottom
        self.borderLayer?.borderColors = [BorderLayer.Border.bottom: UIColor.border]
        self.borderLayer?.borderWidths = [BorderLayer.Border.bottom: 1]
        self.borderLayer?.borderInsets = [BorderLayer.Border.bottom: (10, 10)]
        self.contentView.addSubview(self.titleLabel)
//        self.contentView.addSubview(self.mainView)
//
//        self.mainView.addSubview(self.iconImageView)
//        self.mainView.addSubview(self.titleLabel)
//        self.mainView.addSubview(self.detailLabel)
//        self.mainView.addSubview(self.indicatorImageView)

        themeService.rx
            .bind({ $0.titleColor }, to: self.titleLabel.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
//        self.detailLabel.text = nil
//        self.iconImageView.image = nil
//        self.indicatorImageView.isHidden = true
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
//        self.mainView.width = self.contentView.width - 20 * 2
//        self.mainView.height = self.contentView.height - 5 * 2
//        self.mainView.left = self.mainView.leftWhenCenter
//        self.mainView.top = self.mainView.topWhenCenter
//
//        self.iconImageView.sizeToFit()
//        self.iconImageView.left = 10
//        self.iconImageView.top = self.iconImageView.topWhenCenter
//
//        self.titleLabel.sizeToFit()
//        self.titleLabel.left = self.iconImageView.right + 10
//        self.titleLabel.top = self.titleLabel.topWhenCenter
//
//        self.indicatorImageView.right = self.mainView.width - 10
//        self.indicatorImageView.top = self.indicatorImageView.topWhenCenter
//
//        self.detailLabel.sizeToFit()
//        self.detailLabel.right = self.indicatorImageView.isHidden ?
//            self.indicatorImageView.centerX :
//            self.indicatorImageView.left - 8
//        self.detailLabel.top = self.detailLabel.topWhenCenter
//
//        if self.titleLabel.right >= self.detailLabel.left {
//            self.titleLabel.extendToRight = self.detailLabel.left - 8
//        }
    }

    func bind(reactor: TopicItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.detail }
//            .bind(to: self.detailLabel.rx.attributedText)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.icon }
//            .bind(to: self.iconImageView.rx.image)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { $0.icon == nil }
//            .bind(to: self.iconImageView.rx.isHidden)
//            .disposed(by: self.disposeBag)
//        reactor.state.map { !$0.indicated }
//            .bind(to: self.indicatorImageView.rx.isHidden)
//            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: UIScreen.width / 375 * 80)
    }

}
