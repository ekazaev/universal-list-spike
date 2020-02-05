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

    // Type of instantiation
    static var instantiationType: InstantiationType { get }

}

public extension ReusableView {

    /// Default reuse identifier is set with the class name.
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var instantiationType: InstantiationType {
        return .xibAsClass
    }

}
