//
// AnyLazyViewFactory.swift
// UniversalListController
//

import Foundation
import UIKit

final class AnyViewFactory: ViewFactory {

    private var box: AnyViewFactoryBox

    init<F: ViewFactory>(with factory: F) {
        box = ViewFactoryBox(with: factory)
    }

    func build() -> UIView {
        return box.build()
    }

}

private protocol AnyViewFactoryBox {

    func build() -> UIView

}

private final class ViewFactoryBox<Factory: ViewFactory>: AnyViewFactoryBox {

    private var factory: Factory

    init(with factory: Factory) {
        self.factory = factory
    }

    func build() -> UIView {
        return factory.build()
    }

}
