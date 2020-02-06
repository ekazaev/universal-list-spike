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

    public func build(with context: Input) -> Output {
        return box.build(with: context)
    }
}

private protocol AnyBuilderBox {

    func build<I, O>(with context: I) -> O

}

private final class ViewProxyBox<Builder: InstanceBuilder>: AnyBuilderBox {

    private var builder: Builder

    init(with builder: Builder) {
        self.builder = builder
    }

    func build<I, O>(with context: I) -> O {
        guard let typedContext = context as? Builder.Input,
            let typedOutput = builder.build(with: typedContext) as? O else {
                fatalError("Impossible situation")
        }
        return typedOutput
    }

}
