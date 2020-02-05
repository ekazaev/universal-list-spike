//
// DequeuerBuilder.swift
// UniversalListController
//

import Foundation
import UIKit

public struct DequeuingFactory<D: ReusableViewDequeuer>: ReusableViewFactory {

    private let dequeuer: D

    private let context: D.Context

    public init(using dequeuer: D, with context: D.Context) {
        self.dequeuer = dequeuer
        self.context = context
    }

    public func build<V: ReusableView>() -> V {
        return dequeuer.dequeueView(for: context)
    }

}
