//
// CollectionViewDataSource.swift
// UniversalListController
//

import Foundation
import UIKit

final class CollectionViewDataSourceController<SectionContext, CellContext, ViewSource: ListViewSource>: NSObject, ReusableViewListDataSourceController, UICollectionViewDataSource
    where
    ViewSource.View: UICollectionView,
    CellContext: CellSource,
    CellContext.Cell: UICollectionViewCell {

    typealias View = ViewSource.View

    var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let viewSource: ViewSource
    private let cellDequeuer: CollectionReusableCellDequeuer<ViewSource>

    init(viewSource: ViewSource) {
        self.viewSource = viewSource
        cellDequeuer = CollectionReusableCellDequeuer(viewSource: viewSource)

        super.init()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard viewSource.isViewLoaded else {
            return 0
        }
        return data.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard viewSource.isViewLoaded else {
            return 0
        }
        return data.sections[section].cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellSource = data.sections[indexPath.section].cells[indexPath.item]
        let cell = cellSource.context.getView(with: DequeuingFactory(using: cellDequeuer, with: indexPath))
        return cell
    }

}
