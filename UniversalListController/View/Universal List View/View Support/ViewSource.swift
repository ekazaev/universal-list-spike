//
// ViewSource.swift
// UniversalListController
//

import Foundation
import UIKit

protocol ViewSource {

    associatedtype View: UIView

    var isViewLoaded: Bool { get }

    var view: View { get }

}
