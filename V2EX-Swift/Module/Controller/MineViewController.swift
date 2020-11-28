//
//  MineViewController.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/11/28.
//

import UIKit

class MineViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let simpleCell = ReusableCell<SimpleCell>()
    }

    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    lazy var testButton: SWFrame.Button = {
        let button = SWFrame.Button.init(type: .custom)
        button.backgroundColor = .red
        button.sizeToFit()
        button.size = .init(80)
        return button
    }()
    
    init(_ navigator: NavigatorType, _ reactor: MineViewReactor) {
        defer {
            self.reactor = reactor
        }
        self.dataSource = type(of: self).dataSourceFactory(navigator, reactor)
        super.init(navigator, reactor)
        self.tabBarItem.title = reactor.currentState.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(Reusable.simpleCell)
        self.view.addSubview(self.testButton)
        self.testButton.left = 100
        self.testButton.top = 100
        self.testButton.rx.tap
            .subscribeNext(weak: self, MineViewController.tapTest)
            .disposed(by: self.disposeBag)
    }
    
    func bind(reactor: MineViewReactor) {
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
        reactor.state.map { $0.sections }
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
    
    func tapTest(event: ControlEvent<Void>.Element) {
        self.navigator.present(Router.login.urlString)
    }

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: MineViewReactor)
        -> RxCollectionViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .simple(let item):
                    let cell = collectionView.dequeue(Reusable.simpleCell, for: indexPath)
                    cell.bind(reactor: item)
                    return cell
                }
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                return collectionView.emptyView(for: indexPath, kind: kind)
            }
        )
    }
    
}

extension MineViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.sectionWidth(at: indexPath.section)
        switch self.dataSource[indexPath] {
        case .simple(let item):
            return Reusable.simpleCell.class.size(width: width, item: item)
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        .zero
    }

}
