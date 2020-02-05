//
// TableReusableCellDequeuer.swift
// UniversalListController
//

import Foundation
import UIKit

public final class TableReusableCellDequeuer<Proxy: ViewAccessProxy>: ReusableViewDequeuer where Proxy.View: UITableView {

    private let viewProxy: Proxy
    private var reusableIdentifiers: Set<String> = Set()

    public init(viewProxy: Proxy) {
        self.viewProxy = viewProxy
    }

    public func dequeueView<V: ReusableView>(for indexPath: IndexPath) -> V {
        guard viewProxy.isViewLoaded else {
            assertionFailure("View is not loaded yet")
            return V()
        }

        if !reusableIdentifiers.contains(V.reuseIdentifier) {
            switch V.instantiationType {
            case .xibAsClass:
                let nib = UINib(nibName: V.reuseIdentifier, bundle: Bundle(for: V.self))
                viewProxy.view.register(nib, forCellReuseIdentifier: V.reuseIdentifier)
            case .classImplementation:
                viewProxy.view.register(V.self, forCellReuseIdentifier: V.reuseIdentifier)
            case let .customXib(name: xibName):
                let nib = UINib(nibName: xibName, bundle: Bundle(for: V.self))
                viewProxy.view.register(nib, forCellReuseIdentifier: V.reuseIdentifier)
            }
            reusableIdentifiers.insert(V.reuseIdentifier)
        }
        return dequeueReusableCell(forIndexPath: indexPath)
    }

    private func dequeueReusableCell<V: ReusableView>(forIndexPath indexPath: IndexPath) -> V {
        guard let cell = viewProxy.view.dequeueReusableCell(withIdentifier: V.reuseIdentifier, for: indexPath) as? V else {
            fatalError("No collection view cell could be dequeued with identifier \(V.reuseIdentifier)")
        }

        return cell
    }

}
