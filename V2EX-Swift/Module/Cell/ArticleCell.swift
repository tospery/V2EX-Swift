//
//  ArticleCell.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2021/2/11.
//

import UIKit
import WebKit

class ArticleCell: CollectionCell, ReactorKit.View {

    lazy var webView: WKWebView = {
        let metaString = """
        var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport');
        meta.setAttribute('content', 'width=device-width');
        document.getElementsByTagName('head')[0].appendChild(meta);
        """
        let metaScript = WKUserScript.init(source: metaString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController = WKUserContentController.init()
        userContentController.addUserScript(metaScript)
        let configuration = WKWebViewConfiguration.init()
        configuration.userContentController = userContentController
        let webView = WKWebView.init(
            frame: .zero,
            configuration: configuration
        )
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.webView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.webView.width = self.contentView.width - 15 * 2
        self.webView.height = self.contentView.height
        self.webView.left = 15
        self.webView.top = 0
    }

    func bind(reactor: ArticleItem) {
        super.bind(item: reactor)
        reactor.state.map { $0.html }
            .distinctUntilChanged()
            .bind(to: self.webView.rx.loadHTMLString)
            .disposed(by: self.disposeBag)
        reactor.state.map { _ in }
            .bind(to: self.rx.setNeedsLayout)
            .disposed(by: self.disposeBag)
    }

    override class func size(width: CGFloat, item: BaseCollectionItem) -> CGSize {
        return CGSize(width: width, height: UIScreen.height - navigationContentTopConstant - 50)
    }

}
