//
// CollectionViewDataSource.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

public final class CollectionViewDataSourceController<ViewProxy: ViewAccessProxy, SectionContext, CellContext>: NSObject, UniversalListDataSourceController, UICollectionViewDataSource
    where
    ViewProxy.View: UICollectionView,
    CellContext: CellAdapter,
    CellContext.Cell: UICollectionViewCell {

    public typealias View = ViewProxy.View

    public var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let viewProxy: ViewProxy
    private let cellDequeuer: CollectionReusableCellDequeuer<ViewProxy>

    public init(viewProxy: ViewProxy) {
        self.viewProxy = viewProxy
        cellDequeuer = CollectionReusableCellDequeuer(viewProxy: viewProxy)

        super.init()
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard viewProxy.isViewLoaded else {
            return 0
        }
        return data.sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard viewProxy.isViewLoaded else {
            return 0
        }
        return data.sections[section].items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let adapter = data.sections[indexPath.section].items[indexPath.item]
        let cell = adapter.getView(with: DequeuingFactory(using: cellDequeuer, with: indexPath))
        return cell
    }

}
