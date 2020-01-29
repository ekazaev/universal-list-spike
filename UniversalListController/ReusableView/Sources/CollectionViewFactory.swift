//
// CollectionViewFactory.swift
// UniversalListController
//

import Foundation
import UIKit

class CollectionViewFactory: ViewSource, ViewFactory {

    var isViewLoaded: Bool {
        return collectionView != nil
    }

    lazy var view: UICollectionView = {
        guard let collectionView = collectionView else {
            assertionFailure("Factory method was not called in a correct order")
            return build()
        }
        return collectionView
    }()

    private var collectionView: UICollectionView?

    private(set) var layout: UICollectionViewLayout

    init(collectionViewLayout layout: UICollectionViewLayout) {
        self.layout = layout
    }

    func build() -> UICollectionView {
        if let collectionView = collectionView {
            assertionFailure("Factory method called more then one time")
            return collectionView
        }

        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        self.collectionView = collectionView
        return collectionView
    }

}
