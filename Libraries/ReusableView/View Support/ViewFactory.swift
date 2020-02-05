//
// LazyViewFactory.swift
// UniversalListController
//

import Foundation
import UIKit

public protocol ViewFactory {

    associatedtype View: UIView

    func build() -> View

}
