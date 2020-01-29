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
