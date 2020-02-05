//
// CollectionViewFactory.swift
// UniversalListController
//

import Foundation
import UIKit

public final class CollectionViewFactory: ViewHolder, ViewBuilder {

    public var isViewLoaded: Bool {
        return collectionView != nil
    }

    public lazy var view: UICollectionView = {
        guard let collectionView = collectionView else {
            assertionFailure(
                """
                Factory method build was not called before. Probably view controller 
                has not integrated the view into the stack. You can face potential
                side effects
                """
            )
            return build()
        }
        return collectionView
    }()

    private var collectionView: UICollectionView?

    private(set) var layout: UICollectionViewLayout

    public weak var delegate: UICollectionViewDelegate? {
        didSet {
            guard isViewLoaded else {
                return
            }
            view.delegate = delegate
        }
    }

    public weak var dataSource: UICollectionViewDataSource? {
        didSet {
            guard isViewLoaded else {
                return
            }
            view.dataSource = dataSource
        }
    }

    public init(collectionViewLayout layout: UICollectionViewLayout, delegate: UICollectionViewDelegate? = nil, dataSource: UICollectionViewDataSource? = nil) {
        self.layout = layout
        self.dataSource = dataSource
        self.delegate = delegate
    }

    public func build() -> UICollectionView {
        if let collectionView = collectionView {
            assertionFailure("Factory method called more then one time")
            return collectionView
        }

        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = UIColor.white
        self.collectionView = collectionView
        return collectionView
    }

}
