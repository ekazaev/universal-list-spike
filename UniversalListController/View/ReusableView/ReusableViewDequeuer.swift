//
// ReusableViewDequeuer.swift
// UniversalListController
//

import Foundation
import UIKit

/// Instance that contains ReusableView and can dequeue it using provided parameters
protocol ReusableViewDequeuer {

    // Parameters that container needs to dequeue the reusable view
    associatedtype Context

    func dequeueView<V: ReusableView>(for context: Context) -> V

}
