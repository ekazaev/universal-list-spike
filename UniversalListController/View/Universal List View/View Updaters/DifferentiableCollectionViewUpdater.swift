//
// DifferentiableCollectionViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import UIKit

final class DifferentiableCollectionViewUpdater<CellContext, Source: ViewSource>: ReusableViewListUpdater
    where
    Source.View: UICollectionView,
    CellContext: CellSource,
    CellContext: Differentiable,
    CellContext.Cell: UICollectionViewCell {

    private let dataSource: CollectionViewDataSource<Void, CellContext, Source>

    private let viewSource: Source

    private lazy var collectionView: Source.View = {
        let collection = viewSource.view
        collection.dataSource = dataSource
        collection.reloadData()
        return collection
    }()

    init(viewProvider: Source, dataSource: CollectionViewDataSource<Void, CellContext, Source>) {
        self.dataSource = dataSource
        viewSource = viewProvider
    }

    func update(with data: ListData<Void, CellContext>) {
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
