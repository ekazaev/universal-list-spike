//
// CityTableCell.swift
// UniversalListController
//

import Foundation
import UIKit

final class CityTableCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    private(set) var city: City?

}

extension CityTableCell: ConfigurableReusableView {

    func setup(with city: City) {
        self.city = city
        titleLabel.text = city.city
        descriptionLabel.text = city.description
    }

}
