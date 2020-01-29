//
// AnyLazyViewFactory.swift
// UniversalListController
//

import Foundation
import UIKit

final class AnyViewFactory: ViewFactory {

    private(set) var buildMethod: () -> UIView

    func build() -> UIView {
        return buildMethod()
    }

    init<F: ViewFactory>(with factory: F) {
        buildMethod = factory.build
    }

}
