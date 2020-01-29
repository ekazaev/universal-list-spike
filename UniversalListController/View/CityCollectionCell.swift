//
// CityCollectionView.swift
// UniversalListController
//

import Foundation
import UIKit

class CityCollectionCell: UICollectionViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

}

extension CityCollectionCell: InjectableReusableView {

    func setup(with cityModel: City) {
        titleLabel.text = cityModel.city
        descriptionLabel.text = cityModel.description
    }

}
