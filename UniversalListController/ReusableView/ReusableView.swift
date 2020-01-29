//
// ReusableView.swift
// UniversalListController
//

import Foundation
import UIKit

/// Defines a reusable view.
public protocol ReusableView: UIView {

    /// Default reuse identifier is set with the class name.
    static var reuseIdentifier: String { get }

}

/// This type of ReusableView indicates that non-standard Xib-based
/// behaviour should be used for loading this particular type of ReusableView.
protocol ReusableViewWithNoXib: ReusableView {}

protocol ReusableViewWithinContainer: ReusableView {}

public extension ReusableView {

    /// Default reuse identifier is set with the class name.
    static var reuseIdentifier: String {
        return String(describing: self)
    }

}

extension UICollectionViewCell: ReusableView {}

extension UITableViewCell: ReusableView {}

// MARK: Move separately

/// Instance extending this protocol can build/reuse a reusable view of a specific type.
protocol ReusableViewBuilder {

    func build<V: ReusableView>() -> V

}

struct DequeuerBuilder<D: ReusableViewDequeuer>: ReusableViewBuilder {

    private let dequeuer: D

    private let context: D.Context

    init(using dequeuer: D, with context: D.Context) {
        self.dequeuer = dequeuer
        self.context = context
    }

    func build<V: ReusableView>() -> V {
        return dequeuer.dequeueView(for: context)
    }

}

/// Instance that contains ReusableView and can dequeue it using provided parameters
protocol ReusableViewDequeuer {

    // Parameters that container needs to dequeue the reusable view
    associatedtype Context

    func dequeueView<V: ReusableView>(for context: Context) -> V

}

class TableReusableCellDequeuer<VS: ViewSource>: ReusableViewDequeuer where VS.View: UITableView {

    private let viewSource: VS
    private var reusableIdentifiers: Set<String> = Set()

    init(viewSource: VS) {
        self.viewSource = viewSource
    }

    func dequeueView<V: ReusableView>(for indexPath: IndexPath) -> V {
        if !reusableIdentifiers.contains(V.reuseIdentifier) {
            if V.self is ReusableViewWithNoXib.Type {
                viewSource.view.register(V.self, forCellReuseIdentifier: V.reuseIdentifier)
            } else if !(V.self is ReusableViewWithinContainer.Type) {
                viewSource.view.register(UINib(nibName: V.reuseIdentifier, bundle: nil), forCellReuseIdentifier: V.reuseIdentifier)
            }
            reusableIdentifiers.insert(V.reuseIdentifier)
        }
        return dequeueReusableCell(forIndexPath: indexPath)
    }

    private func dequeueReusableCell<V: ReusableView>(forIndexPath indexPath: IndexPath) -> V {
        guard let cell = viewSource.view.dequeueReusableCell(withIdentifier: V.reuseIdentifier, for: indexPath) as? V else {
            fatalError("No collection view cell could be dequeued with identifier \(V.reuseIdentifier)")
        }

        return cell
    }

}
