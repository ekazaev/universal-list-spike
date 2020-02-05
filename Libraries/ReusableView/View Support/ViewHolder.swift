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
