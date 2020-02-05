//
// ReusableViewFactory.swift
// UniversalListController
//

import Foundation
import UIKit

/// Instance extending this protocol can build/reuse a reusable view of a specific type.
public protocol ReusableViewFactory {

    func build<V: ReusableView>() -> V

}
