//
// ConfigurableReusableView.swift
// UniversalListController
//

import Foundation
import UIKit

public protocol ConfigurableReusableView: ReusableView {

    associatedtype Data

    func setup(with data: Data)

}
