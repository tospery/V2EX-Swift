//
//  TopicTitleCell.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2021/2/11.
//

import UIKit

class TopicTitleCell: CollectionCell, ReactorKit.View {

    lazy var titleLabel: SWLabel = {
        let label = SWLabel()
        label.numberOfLines = 0
        label.font = .bold(17)
        label.sizeToFit()
        label.qmui_lineHeight = flat(label.font.lineHeight + 8)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.titleLabel)
        
        themeService.rx
            .bind({ $0.foregroundColor }, to: self.titleLabel.rx.textColor)
            .disposed(by: self.rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let margin = 20.f
        self.titleLabel.sizeToFit()
        self.titleLabel.height = self.contentView.height
        self.titleLabel.width = self.contentView.width - margin * 2
        self.titleLabel.left = margin
        self.titleLabel.top = 0
    }

    func bind(reactor: TopicTitleItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.title }
            .distinctUntilChanged()
            .bind(to: self.titleLabel.rx.text)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: 100)
    }

}
