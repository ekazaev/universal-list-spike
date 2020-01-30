//
// DifferentiableCollectionViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

final class DifferentiableCollectionViewUpdater<DataSource: ReusableViewListDataSourceController & UICollectionViewDataSource, ViewSource: ListViewSource>: ReusableViewListUpdater
    where
    ViewSource.View: UICollectionView,
    DataSource.View: UICollectionView,
    DataSource.SectionContext == Void,
    DataSource.CellContext: CellSource,
    DataSource.CellContext: Differentiable,
    DataSource.CellContext.Cell: UICollectionViewCell {

    private weak var dataSource: DataSource?

    private let viewSource: ViewSource

    private lazy var collectionView: ViewSource.View = {
        let collection = viewSource.view
        collection.dataSource = dataSource
        collection.reloadData()
        return collection
    }()

    init(viewSource: ViewSource, dataSource: DataSource) {
        self.dataSource = dataSource
        self.viewSource = viewSource
    }

    func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        guard let dataSource = dataSource else {
            return
        }
        guard viewSource.isViewLoaded else {
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
