//
// Created by Eugene Kazaev on 26/08/2019.
// Copyright (c) 2019 Eugene Kazaev. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol CustomTabViewControllerDelegate {

    @objc optional func customTabViewController(_ tabViewController: CustomTabViewController, didSelect viewController: UIViewController)

}
