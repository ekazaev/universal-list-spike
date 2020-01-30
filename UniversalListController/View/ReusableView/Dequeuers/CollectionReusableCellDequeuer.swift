//
// CollectionReusableCellDequeuer.swift
// UniversalListController
//

import Foundation
import UIKit

final class CollectionReusableCellDequeuer<ViewSource: ListViewSource>: ReusableViewDequeuer where ViewSource.View: UICollectionView {

    private let viewSource: ViewSource
    private var reusableIdentifiers: Set<String> = Set()

    init(viewSource: ViewSource) {
        self.viewSource = viewSource
    }

    func dequeueView<V: ReusableView>(for indexPath: IndexPath) -> V {
        guard viewSource.isViewLoaded else {
            assertionFailure("View is not loaded yet")
            return V()
        }

        if !reusableIdentifiers.contains(V.reuseIdentifier) {
            if V.self is ReusableViewWithNoXib.Type {
                viewSource.view.register(V.self, forCellWithReuseIdentifier: V.reuseIdentifier)
            } else if !(V.self is ReusableViewWithinContainer.Type) {
                viewSource.view.register(UINib(nibName: V.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: V.reuseIdentifier)
            }
            reusableIdentifiers.insert(V.reuseIdentifier)
        }
        return dequeueReusableCell(forIndexPath: indexPath)
    }

    private func dequeueReusableCell<V: ReusableView>(forIndexPath indexPath: IndexPath) -> V {
        guard let cell = viewSource.view.dequeueReusableCell(withReuseIdentifier: V.reuseIdentifier, for: indexPath) as? V else {
            fatalError("No collection view cell could be dequeued with identifier \(V.reuseIdentifier)")
        }

        return cell
    }

}
