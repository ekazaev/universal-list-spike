//
// CollectionViewDataSource.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

public final class CollectionViewDataSourceController<SectionContext, CellContext, ListHolder: ViewHolder>: NSObject, UniversalListDataSourceController, UICollectionViewDataSource
    where
    ListHolder.View: UICollectionView,
    CellContext: CellAdapter,
    CellContext.Cell: UICollectionViewCell {

    public typealias View = ListHolder.View

    public var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let holder: ListHolder
    private let cellDequeuer: CollectionReusableCellDequeuer<ListHolder>

    public init(holder: ListHolder) {
        self.holder = holder
        cellDequeuer = CollectionReusableCellDequeuer(holder: holder)

        super.init()
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard holder.isViewLoaded else {
            return 0
        }
        return data.sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard holder.isViewLoaded else {
            return 0
        }
        return data.sections[section].cells.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = data.sections[indexPath.section].cells[indexPath.item]
        let cell = cellData.context.getView(with: DequeuingFactory(using: cellDequeuer, with: indexPath))
        return cell
    }

}
