//
// CityTableCell.swift
// UniversalListController
//

import Foundation
import ReusableView
import UIKit

final class PersonTableCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    private(set) var person: Person?

}

extension PersonTableCell: ConfigurableReusableView {

    func setup(with person: Person) {
        self.person = person
        titleLabel.text = person.name
        descriptionLabel.text = person.description
    }

}
