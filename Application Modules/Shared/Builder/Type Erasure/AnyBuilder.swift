//
// Created by Eugene Kazaev on 06/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation

public final class AnyBuilder<Input, Output>: InstanceBuilder {

    private var box: AnyBuilderBox

    public init<B: InstanceBuilder>(with builder: B) where B.Input == Input, B.Output == Output {
        box = ViewProxyBox(with: builder)
    }

    public func build(with input: Input) -> Output {
        return box.build(with: input)
    }
}

private protocol AnyBuilderBox {

    func build<I, O>(with input: I) -> O

}

private final class ViewProxyBox<Builder: InstanceBuilder>: AnyBuilderBox {

    private var builder: Builder

    init(with builder: Builder) {
        self.builder = builder
    }

    func build<I, O>(with input: I) -> O {
        guard let typedInput = input as? Builder.Input,
            let typedOutput = builder.build(with: typedInput) as? O else {
                fatalError("Impossible situation")
        }
        return typedOutput
    }

}
