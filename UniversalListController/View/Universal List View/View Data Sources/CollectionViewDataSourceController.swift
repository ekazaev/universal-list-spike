//
// CollectionViewDataSource.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

final class CollectionViewDataSourceController<SectionContext, CellContext, ListHolder: ViewHolder>: NSObject, ReusableViewListDataSourceController, UICollectionViewDataSource
    where
    ListHolder.View: UICollectionView,
    CellContext: CellAdapter,
    CellContext.Cell: UICollectionViewCell {

    typealias View = ListHolder.View

    var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let holder: ListHolder
    private let cellDequeuer: CollectionReusableCellDequeuer<ListHolder>

    init(holder: ListHolder) {
        self.holder = holder
        cellDequeuer = CollectionReusableCellDequeuer(holder: holder)

        super.init()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard holder.isViewLoaded else {
            return 0
        }
        return data.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard holder.isViewLoaded else {
            return 0
        }
        return data.sections[section].cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = data.sections[indexPath.section].cells[indexPath.item]
        let cell = cellData.context.getView(with: DequeuingFactory(using: cellDequeuer, with: indexPath))
        return cell
    }

}
