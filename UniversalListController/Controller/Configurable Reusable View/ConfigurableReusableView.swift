//
// ConfigurableReusableView.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

protocol ConfigurableReusableView: ReusableView {

    associatedtype Data

    func setup(with data: Data)

}
