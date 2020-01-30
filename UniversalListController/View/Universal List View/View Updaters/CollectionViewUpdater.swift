//
// CollectionViewUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

final class CollectionViewUpdater<SectionContext, CellContext, Source: ViewSource>: ReusableViewListUpdater
    where
    Source.View: UICollectionView,
    CellContext: CellSource,
    CellContext.Cell: UICollectionViewCell {

    private let dataSource: CollectionViewDataSource<SectionContext, CellContext, Source>

    private let viewSource: Source

    private lazy var collectionView: Source.View = {
        let collectionView = viewSource.view
        collectionView.dataSource = dataSource
        collectionView.reloadData()
        return collectionView
    }()

    init(viewSource: Source, dataSource: CollectionViewDataSource<SectionContext, CellContext, Source>) {
        self.dataSource = dataSource
        self.viewSource = viewSource
    }

    func update(with data: ListData<SectionContext, CellContext>) {
        dataSource.data = data
        guard viewSource.isViewLoaded else {
            return
        }
        collectionView.reloadData()
    }

}
