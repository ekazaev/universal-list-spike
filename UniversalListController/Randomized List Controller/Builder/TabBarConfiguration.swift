//
// TabBarConfiguration.swift
// UniversalListController
//

import Foundation
import UIKit

struct TabBarConfiguration {

    let image: UIImage?

    let title: String?

    init(image: UIImage? = nil,
         title: String? = nil) {
        self.image = image
        self.title = title
    }

}
