//
// FlatEventHandler.swift
// UniversalListController
//

import Foundation
import UIKit

final class RandomizingEventHandler<ViewUpdater: ReusableViewListUpdater, Provider: DataProvider, Transformer: DataTransformer>
    where
    Transformer.Target == ListData<ViewUpdater.SectionContext, ViewUpdater.CellContext>,
    Transformer.Source == Provider.Data {

    private var viewUpdater: ViewUpdater

    private var dataProvider: Provider

    private var dataTransformer: Transformer

    private var timer: Timer!

    init(viewUpdater: ViewUpdater, dataProvider: Provider, dataTransformer: Transformer) {
        self.viewUpdater = viewUpdater
        self.dataProvider = dataProvider
        self.dataTransformer = dataTransformer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            let entities = dataProvider.getData()
            let data = dataTransformer.transform(entities)
            self?.viewUpdater.update(with: data)
        }
    }
}
