//
// CollectionViewUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

final class CollectionViewUpdater<DataSource: ReusableViewListDataSourceController & UICollectionViewDataSource, ListHolder: ViewHolder>: ReusableViewListUpdater
    where
    ListHolder.View: UICollectionView,
    DataSource.View: UICollectionView,
    DataSource.CellContext: CellAdapter,
    DataSource.CellContext.Cell: UICollectionViewCell {

    private weak var dataSource: DataSource?

    private let holder: ListHolder

    private lazy var collectionView: ListHolder.View = {
        let collectionView = holder.view
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        return collectionView
    }()

    init(holder: ListHolder, dataSource: DataSource) {
        self.dataSource = dataSource
        self.holder = holder
    }

    func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        guard let dataSource = dataSource else {
            return
        }
        dataSource.data = data
        guard holder.isViewLoaded else {
            return
        }
        collectionView.reloadData()
    }

}
