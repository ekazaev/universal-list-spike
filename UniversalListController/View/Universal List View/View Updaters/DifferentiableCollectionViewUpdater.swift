//
// DifferentiableCollectionViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

final class DifferentiableCollectionViewUpdater<DataSource: ReusableViewListDataSourceController & UICollectionViewDataSource, ListHolder: ViewHolder>: ReusableViewListUpdater
    where
    ListHolder.View: UICollectionView,
    DataSource.View: UICollectionView,
    DataSource.SectionContext == Void,
    DataSource.CellContext: CellAdapter,
    DataSource.CellContext: Differentiable,
    DataSource.CellContext.Cell: UICollectionViewCell {

    private weak var dataSource: DataSource?

    private let holder: ListHolder

    private lazy var collectionView: ListHolder.View = {
        let collection = holder.view
        collection.dataSource = dataSource
        collection.reloadData()
        return collection
    }()

    init(holder: ListHolder, dataSource: DataSource) {
        self.dataSource = dataSource
        self.holder = holder
    }

    func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        guard let dataSource = dataSource else {
            return
        }
        guard holder.isViewLoaded else {
            dataSource.data = data
            return
        }

        let source = dataSource.data.getAsDifferentiableArray()
        let target = data.getAsDifferentiableArray()
        let changeSet = StagedChangeset(source: source, target: target)
        collectionView.reload(using: changeSet) { data in
            let sections = data.map { SectionData(cells: $0.elements.map { CellData(context: $0) }) }
            dataSource.data = ListData(sections: sections)
        }
    }

}
