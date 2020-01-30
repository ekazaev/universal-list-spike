//
// ViewSource.swift
// UniversalListController
//

import Foundation
import UIKit

protocol ListViewSource {

    associatedtype View: UIView

    var isViewLoaded: Bool { get }

    var view: View { get }

}
