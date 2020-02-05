//
// CollectionViewUpdater.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit
import UniversalList

public final class CollectionViewUpdater<DataSource: UniversalListDataSourceController & UICollectionViewDataSource, ListHolder: ViewHolder>: UniversalListUpdater
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

    public init(holder: ListHolder, dataSource: DataSource) {
        self.dataSource = dataSource
        self.holder = holder
    }

    public func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
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