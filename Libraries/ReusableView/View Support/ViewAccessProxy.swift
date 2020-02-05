//
// ViewProxy.swift
// UniversalListController
//

import Foundation
import UIKit

// View Access Proxy hides view object inside and used to initialize this view dependent objects
// before the view actually created.
// Also it is very use full on the development stage to controll that someone is trying to access
// the view before it were loaded by the view controller. Helps to avoid side effects that view is
// being accessed in `didSet` of the `UIViewController` for example before the view controller was
// loaded
public protocol ViewAccessProxy {

    associatedtype View: UIView

    var isViewLoaded: Bool { get }

    var view: View { get }

}

public protocol ViewBuilder {

    associatedtype View: UIView

    var view: View { get }

    func build() -> View

}
