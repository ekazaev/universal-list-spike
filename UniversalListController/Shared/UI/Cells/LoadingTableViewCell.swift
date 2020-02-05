//
// LoadingTableViewCell.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

class LoadingTableViewCell: UITableViewCell, ReusableView {

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    override func prepareForReuse() {
        activityIndicator.startAnimating()
    }

}
