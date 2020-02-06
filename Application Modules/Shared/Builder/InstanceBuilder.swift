//
// Created by Eugene Kazaev on 06/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation

public protocol InstanceBuilder {

    associatedtype Input

    associatedtype Output

    func build(with input: Input) -> Output

}

public extension InstanceBuilder where Input == Void {

    func build() -> Output {
        return build(with: ())
    }

}
