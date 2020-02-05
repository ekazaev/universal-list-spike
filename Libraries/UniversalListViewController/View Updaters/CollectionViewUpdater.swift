//
// CollectionViewUpdater.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit
import UniversalList

public final class CollectionViewUpdater<DataSource: UniversalListDataSourceController & UICollectionViewDataSource, Proxy: ViewAccessProxy>: UniversalListUpdater
    where
    Proxy.View: UICollectionView,
    DataSource.View: UICollectionView,
    DataSource.CellContext: CellAdapter,
    DataSource.CellContext.Cell: UICollectionViewCell {

    private weak var dataSource: DataSource?

    private let viewProxy: Proxy

    private lazy var collectionView: Proxy.View = {
        let collectionView = viewProxy.view
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        return collectionView
    }()

    public init(viewProxy: Proxy, dataSource: DataSource) {
        self.dataSource = dataSource
        self.viewProxy = viewProxy
    }

    public func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        guard let dataSource = dataSource else {
            return
        }
        dataSource.data = data
        guard viewProxy.isViewLoaded else {
            return
        }
        collectionView.reloadData()
    }

}
