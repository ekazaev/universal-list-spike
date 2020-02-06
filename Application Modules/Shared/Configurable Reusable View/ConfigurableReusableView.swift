//
// ConfigurableReusableView.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

public protocol ConfigurableReusableView: ReusableView {

    associatedtype Data

    func setup(with data: Data)

}
