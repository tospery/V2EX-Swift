//
//  TopicDetailViewController.swift
//  V2EX-Swift
//
//  Created by 杨建祥 on 2021/2/11.
//

import UIKit

class TopicDetailViewController: CollectionViewController, ReactorKit.View {
    
    struct Reusable {
        static let titleCell    = ReusableCell<TopicTitleCell>()
        static let userCell     = ReusableCell<TopicUserCell>()
        static let articleCell  = ReusableCell<ArticleCell>()
    }

    let dataSource: RxCollectionViewSectionedReloadDataSource<Section>
    
    init(_ navigator: NavigatorType, _ reactor: TopicDetailViewReactor) {
        defer {
            self.reactor = reactor
        }
        self.dataSource = type(of: self).dataSourceFactory(navigator, reactor)
        super.init(navigator, reactor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(Reusable.titleCell)
        self.collectionView.register(Reusable.userCell)
        self.collectionView.register(Reusable.articleCell)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func bind(reactor: TopicDetailViewReactor) {
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

    static func dataSourceFactory(_ navigator: NavigatorType, _ reactor: TopicDetailViewReactor)
        -> RxCollectionViewSectionedReloadDataSource<Section> {
        return .init(
            configureCell: { _, collectionView, indexPath, sectionItem in
                switch sectionItem {
                case .topicTitle(let item):
                    let cell = collectionView.dequeue(Reusable.titleCell, for: indexPath)
                    cell.reactor = item
                    return cell
                case .topicUser(let item):
                    let cell = collectionView.dequeue(Reusable.userCell, for: indexPath)
                    cell.reactor = item
                    return cell
                case .article(let item):
                    let cell = collectionView.dequeue(Reusable.articleCell, for: indexPath)
                    cell.reactor = item
                    item.state.map { $0.height }
                        .distinctUntilChanged()
                        .skip(1)
                        .subscribe(onNext: { height in
                            log("开始reload -> \(height)")
                            collectionView.reloadData()
                        }).disposed(by: cell.disposeBag)
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
    
    func handleHeight1(event: ControlEvent<CGFloat>.Element) {
        log("")
    }
    
    static func handleHeight3(event: CGFloat) {
        log("")
    }
    
    static func handleHeight2(event: ControlEvent<CGFloat>.Element) {
        log("")
    }
    
}

extension TopicDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.sectionWidth(at: indexPath.section)
        switch self.dataSource[indexPath] {
        case .topicTitle(let item):
            return Reusable.titleCell.class.size(width: width, item: item)
        case .topicUser(let item):
            return Reusable.userCell.class.size(width: width, item: item)
        case .article(let item):
            return Reusable.articleCell.class.size(width: width, item: item)
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
