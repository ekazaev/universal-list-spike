//
// DequeuerBuilder.swift
// UniversalListController
//

import Foundation
import UIKit

struct DequeuingFactory<D: ReusableViewDequeuer>: ReusableViewFactory {

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
