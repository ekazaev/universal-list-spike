//
// ConfigurableReusableView.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit
import UniversalList

public protocol ConfigurableReusableView: ReusableView {

    associatedtype Data

    func setup(with data: Data)

}
