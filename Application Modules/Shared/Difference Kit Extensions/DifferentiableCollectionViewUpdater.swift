//
// DifferentiableCollectionViewUpdater.swift
// UniversalListController
//

import DifferenceKit
import Foundation
import ReusableView
import UIKit
import UniversalList

public final class DifferentiableCollectionViewUpdater<DataSource: UniversalListDataSourceController & UICollectionViewDataSource, Proxy: ViewAccessProxy>: UniversalListUpdater
    where
    Proxy.View: UICollectionView,
    DataSource.View: UICollectionView,
    DataSource.SectionContext == Void,
    DataSource.CellContext: CellAdapter,
    DataSource.CellContext: Differentiable,
    DataSource.CellContext.Cell: UICollectionViewCell {

    private weak var dataSource: DataSource?

    private let viewProxy: Proxy

    private lazy var collectionView: Proxy.View = {
        let collection = viewProxy.view
        collection.dataSource = dataSource
        collection.reloadData()
        return collection
    }()

    public init(viewProxy: Proxy, dataSource: DataSource) {
        self.dataSource = dataSource
        self.viewProxy = viewProxy
    }

    public func update(with data: ListData<DataSource.SectionContext, DataSource.CellContext>) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            guard let dataSource = self.dataSource else {
                return
            }
            guard self.viewProxy.isViewLoaded else {
                dataSource.data = data
                return
            }

            let source = dataSource.data.getAsDifferentiableArray()
            let target = data.getAsDifferentiableArray()
            let changeSet = StagedChangeset(source: source, target: target)
            self.collectionView.reload(using: changeSet) { data in
                let sections = data.map {
                    SectionData(items: $0.elements)
                }
                dataSource.data = ListData(sections: sections)
            }
        }
    }

}
