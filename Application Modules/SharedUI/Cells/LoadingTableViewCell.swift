//
// LoadingTableViewCell.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

public class LoadingTableViewCell: UITableViewCell, ReusableView {

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    public override func prepareForReuse() {
        activityIndicator.startAnimating()
    }

}
