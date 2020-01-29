//
// CollectionViewUpdater.swift
// UniversalListController
//

import Foundation
import UIKit

class CollectionViewUpdater<SectionContext, CellContext, VS: ViewSource>: ReusableViewListUpdater
    where
    VS.View: UICollectionView,
    CellContext: CellSource,
    CellContext.Cell: UICollectionViewCell {

    private let dataSource: CollectionViewDataSource<SectionContext, CellContext, VS>

    private let viewSource: VS

    private lazy var collectionView: VS.View = {
        let collectionView = viewSource.view
        collectionView.dataSource = dataSource
        return collectionView
    }()

    init(viewSource: VS, dataSource: CollectionViewDataSource<SectionContext, CellContext, VS>) {
        self.dataSource = dataSource
        self.viewSource = viewSource
    }

    func update(with data: ListData<SectionContext, CellContext>) {
        guard viewSource.isViewLoaded else {
            return
        }

        dataSource.data = data
        collectionView.reloadData()
    }

}
