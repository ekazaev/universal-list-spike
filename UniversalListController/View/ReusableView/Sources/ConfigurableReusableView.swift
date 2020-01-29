//
// ConfigurableReusableView.swift
// UniversalListController
//

import Foundation
import UIKit

protocol ConfigurableReusableView: ReusableView {

    associatedtype Data

    func setup(with data: Data)

}
