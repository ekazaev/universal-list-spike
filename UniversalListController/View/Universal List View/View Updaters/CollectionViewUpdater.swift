//
// CollectionViewUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

final class CollectionViewUpdater<DataSource: ReusableViewListDataSource & UICollectionViewDataSource, ViewSource: ListViewSource>: ReusableViewListUpdater
    where
    ViewSource.View: UICollectionView,
    DataSource.View: UICollectionView,
    DataSource.CellContext: CellSource,
    DataSource.CellContext.Cell: UICollectionViewCell {

    private var dataSource: DataSource

    private let viewSource: ViewSource

    private lazy var collectionView: ViewSource.View = {
        let collectionView = viewSource.view
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        return collectionView
    }()

    init(viewSource: ViewSource, dataSource: DataSource) {
        self.dataSource = dataSource
        self.viewSource = viewSource
    }

    func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        dataSource.data = data
        guard viewSource.isViewLoaded else {
            return
        }
        collectionView.reloadData()
    }

}
