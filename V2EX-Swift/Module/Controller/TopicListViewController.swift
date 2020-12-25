//
//  TopicListViewController.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2020/12/12.
//

import UIKit

class TopicListViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let topicCell = ReusableCell<TopicCell>()
    }

    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    init(_ navigator: NavigatorType, _ reactor: TopicListViewReactor) {
        defer {
            self.reactor = reactor
        }
        self.dataSource = type(of: self).dataSourceFactory(navigator, reactor)
        super.init(navigator, reactor)
        self.hidesNavigationBar = reactor.parameters[Parameter.hideNavBar] as? Bool ?? true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(Reusable.topicCell)
    }
    
    func bind(reactor: TopicListViewReactor) {
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
//        reactor.state.map { $0.isLoading }
//            .distinctUntilChanged()
//            .bind(to: self.rx.loading())
//            .disposed(by: self.disposeBag)
        reactor.state.map { $0.sections }
            .bind(to: self.collectionView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
    
    func tapTest(event: ControlEvent<Void>.Element) {
        self.navigator.present(Router.login.urlString, wrap: NavigationController.self)
    }

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: TopicListViewReactor)
        -> RxCollectionViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .topic(let item):
                    let cell = collectionView.dequeue(Reusable.topicCell, for: indexPath)
                    cell.bind(reactor: item)
                    return cell
                default:
                    return collectionView.emptyCell(for: indexPath)
                }
            },
            configureSupplementaryView: { _, collectionView, kind, indexPath in
                return collectionView.emptyView(for: indexPath, kind: kind)
            }
        )
    }
    
}

extension TopicListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.sectionWidth(at: indexPath.section)
        switch self.dataSource[indexPath] {
        case .topic(let item):
            return Reusable.topicCell.class.size(width: width, item: item)
        default:
            return .zero
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
