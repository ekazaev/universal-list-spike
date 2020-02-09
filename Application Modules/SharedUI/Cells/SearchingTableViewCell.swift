//
// LoadingTableViewCell.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

public class SearchingTableViewCell: UITableViewCell, ReusableView {

    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    public override func prepareForReuse() {
        activityIndicator.startAnimating()
    }

}
