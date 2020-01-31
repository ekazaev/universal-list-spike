//
// TableReusableCellDequeuer.swift
// UniversalListController
//

import Foundation
import UIKit

final class TableReusableCellDequeuer<ListHolder: ViewHolder>: ReusableViewDequeuer where ListHolder.View: UITableView {

    private let holder: ListHolder
    private var reusableIdentifiers: Set<String> = Set()

    init(holder: ListHolder) {
        self.holder = holder
    }

    func dequeueView<V: ReusableView>(for indexPath: IndexPath) -> V {
        guard holder.isViewLoaded else {
            assertionFailure("View is not loaded yet")
            return V()
        }

        if !reusableIdentifiers.contains(V.reuseIdentifier) {
            if V.self is ReusableViewWithNoXib.Type {
                holder.view.register(V.self, forCellReuseIdentifier: V.reuseIdentifier)
            } else if !(V.self is ReusableViewWithinContainer.Type) {
                holder.view.register(UINib(nibName: V.reuseIdentifier, bundle: nil), forCellReuseIdentifier: V.reuseIdentifier)
            }
            reusableIdentifiers.insert(V.reuseIdentifier)
        }
        return dequeueReusableCell(forIndexPath: indexPath)
    }

    private func dequeueReusableCell<V: ReusableView>(forIndexPath indexPath: IndexPath) -> V {
        guard let cell = holder.view.dequeueReusableCell(withIdentifier: V.reuseIdentifier, for: indexPath) as? V else {
            fatalError("No collection view cell could be dequeued with identifier \(V.reuseIdentifier)")
        }

        return cell
    }

}
