//
// Created by Eugene Kazaev on 09/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import UniversalList

/// Extension that helps to avoid specifying `TableViewDataSourceController` types of `SectionContext` and `CellContext` based on type
/// of `DataTransformer` it is going to be used later.
public extension TableViewDataSourceController {

    convenience init<DT: DataTransformer>(viewProxy: ViewProxy, usingWith dataTransformer: DT) where DT.Output == ListData<SectionContext, CellContext> {
        self.init(viewProxy: viewProxy)
    }

}

/// Extension that helps to avoid specifying `CollectionViewDataSourceController` types of `SectionContext` and `CellContext` based on type
/// of `DataTransformer` it is going to be used later.
public extension CollectionViewDataSourceController {

    convenience init<DT: DataTransformer>(viewProxy: ViewProxy, usingWith dataTransformer: DT) where DT.Output == ListData<SectionContext, CellContext> {
        self.init(viewProxy: viewProxy)
    }

}
