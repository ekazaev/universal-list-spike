//
// TabBarConfiguration.swift
// UniversalListController
//

import Foundation
import UIKit

public struct TabBarConfiguration {

    public let image: UIImage?

    public let title: String?

    public init(image: UIImage? = nil,
                title: String? = nil) {
        self.image = image
        self.title = title
    }

}
