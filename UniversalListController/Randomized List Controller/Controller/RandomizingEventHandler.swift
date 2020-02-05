//
// FlatEventHandler.swift
// UniversalListController
//

import Foundation
import UIKit
import UniversalList
import UniversalListViewController

final class RandomizingEventHandler<ViewUpdater: UniversalListUpdater, Provider: DataProvider, Transformer: DataTransformer>: UniversalListViewControllerEventHandler
    where
    Provider.Request == String,
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
            dataProvider.getData(with: "") { [weak self] result in
                guard let self = self, let entities = try? result.get() else {
                    return
                }
                let data = dataTransformer.transform(entities)
                self.viewUpdater.update(with: data)
            }
        }
    }
}
