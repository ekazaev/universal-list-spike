//
// InjectableReusableView.swift
// UniversalListController
//

import Foundation
import UIKit

protocol InjectableReusableView: ReusableView {

    associatedtype Data

    func setup(with data: Data)

}
