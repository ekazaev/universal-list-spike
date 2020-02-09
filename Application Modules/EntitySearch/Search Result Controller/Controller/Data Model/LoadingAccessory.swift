//
// ListState.swift
// UniversalListController
//

import DifferenceKit
import Foundation

enum LoadingAccessory {

    case pleaseWait

    case loadingMore

}

extension LoadingAccessory: Equatable {}

extension LoadingAccessory: Differentiable {}
