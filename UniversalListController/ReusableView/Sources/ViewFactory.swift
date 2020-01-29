//
// LazyViewFactory.swift
// UniversalListController
//

import Foundation
import UIKit

protocol ViewFactory {

    associatedtype View: UIView

    func build() -> View

}
