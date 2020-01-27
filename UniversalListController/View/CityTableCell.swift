//
// CityTableCell.swift
// UniversalListController
//

import Foundation
import UIKit

final class CityTableCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

}

extension CityTableCell: SimpleCellSourceCell {

    func setup(with cityModel: City) {
        titleLabel.text = cityModel.city
        descriptionLabel.text = cityModel.description
    }
}
