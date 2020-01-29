//
// DifferentiableCollectionViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

class DifferentiableCollectionViewUpdater<CellContext, VS: ViewSource>: ReusableViewListUpdater
    where
    VS.View: UICollectionView,
    CellContext: CellSource,
    CellContext: Differentiable,
    CellContext.Cell: UICollectionViewCell {

    private let dataSource: CollectionViewDataSource<Void, CellContext, VS>

    private let viewSource: VS

    private lazy var collectionView: VS.View = {
        let collection = viewSource.view
        collection.dataSource = dataSource
        collection.reloadData()
        return collection
    }()

    init(viewProvider: VS, dataSource: CollectionViewDataSource<Void, CellContext, VS>) {
        self.dataSource = dataSource
        viewSource = viewProvider
    }

    func update(with data: ListData<Void, CellContext>) {
        guard viewSource.isViewLoaded else {
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
