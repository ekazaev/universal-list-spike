//
// ViewHolder.swift
// UniversalListController
//

import Foundation
import UIKit

public protocol ViewHolder {

    associatedtype View: UIView

    var isViewLoaded: Bool { get }

    var view: View { get }

}

public protocol ViewBuilder {

    associatedtype View: UIView

    var view: View { get }

    func build() -> View

}
