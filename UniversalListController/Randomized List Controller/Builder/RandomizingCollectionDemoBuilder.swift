//
// RandomizingCollectionDemoBuilder.swift
// UniversalListController
//

import Foundation
import UIKit
import ReusableView
import UniversalListViewController
import DifferenceKit

class RandomizingCollectionDemoBuilder<DP: DataProvider, Cell: UICollectionViewCell & ConfigurableReusableView>
    where
    DP.Request == String,
    Cell.Data: Differentiable,
    [Cell.Data] == DP.Data {

    private let dataProvider: DP

    init(dataProvider: DP) {
        self.dataProvider = dataProvider
    }

    func build() -> UIViewController {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        let collectionViewFactory = CollectionViewFactory(collectionViewLayout: layout)
        let collectionDataSource = CollectionViewDataSourceController<Void, ConfigurableCellAdapter<Cell>, CollectionViewFactory>(holder: collectionViewFactory)

        let collectionViewUpdater = DifferentiableCollectionViewUpdater(holder: collectionViewFactory, dataSource: collectionDataSource)
        let collectionDataTransformer = ConfigurableDataTransformer<[[Cell.Data]], Cell>()

        let collectionEventHandler = RandomizingEventHandler(viewUpdater: collectionViewUpdater, dataProvider: EnclosingArrayDataProvider(for: ShufflingDataProvider(for: dataProvider)), dataTransformer: collectionDataTransformer)
        let collectionViewController = UniversalListViewController(
            view: collectionViewFactory.build(),
            dataSourceController: collectionDataSource,
            delegateController: SimpleCollectionViewDelegateController()
        )
        collectionViewController.eventHandler = collectionEventHandler
        return collectionViewController
    }

}