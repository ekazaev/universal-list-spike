//
// CityCollectionView.swift
// UniversalListController
//

import Foundation
import UIKit

class CityCollectionCell: UICollectionViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    private(set) var city: City?

}

extension CityCollectionCell: ConfigurableReusableView {

    func setup(with city: City) {
        self.city = city
        titleLabel.text = city.city
        descriptionLabel.text = city.description
    }

}
