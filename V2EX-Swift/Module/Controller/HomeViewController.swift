//
//  HomeViewController.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class HomeViewController: ScrollViewController, ReactorKit.View {
    
    lazy var paging: PagingViewController = {
        let paging = PagingViewController.init()
        paging.borderOptions = .hidden
        paging.menuItemSize = .selfSizing(estimatedWidth: 100, height: 40)
        paging.menuItemLabelSpacing = 10
        paging.indicatorOptions = .hidden
        paging.font = .systemFont(ofSize: 15)
        paging.selectedFont = .systemFont(ofSize: 15)
        paging.textColor = .caption
        paging.selectedTextColor = .foreground
        return paging
    }()
    
    init(_ navigator: NavigatorType, _ reactor: HomeViewReactor) {
        defer {
            self.reactor = reactor
        }
        super.init(navigator, reactor)
        self.tabBarItem.title = reactor.currentState.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChild(self.paging)
        self.view.addSubview(self.paging.view)
        self.paging.view.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(navigationContentTopConstant)
            make.bottom.equalToSuperview().offset(-tabBarHeight)
        }
        self.paging.didMove(toParent: self)
        self.paging.dataSource = self
    }
    
    func bind(reactor: HomeViewReactor) {
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
//        reactor.state.map { $0.sections }
//            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
//            .disposed(by: self.disposeBag)
    }
    
}

extension HomeViewController: PagingViewControllerDataSource {
    
    func numberOfViewControllers(in pagingViewController: PagingViewController) -> Int {
        self.reactor!.currentState.nodes.count
    }
    
    func pagingViewController(_: PagingViewController, pagingItemAt index: Int) -> PagingItem {
        let node = self.reactor!.currentState.nodes[index]
        return PagingIndexItem.init(index: node.id, title: node.title)
    }
    
    func pagingViewController(_: PagingViewController, viewControllerAt index: Int) -> UIViewController {
        let node = self.reactor!.currentState.nodes[index]
        let viewReactor = TopicListViewReactor.init(self.reactor!.provider, [Parameter.model: node])
        let viewController = TopicListViewController.init(self.navigator, viewReactor)
        return viewController
    }

}
