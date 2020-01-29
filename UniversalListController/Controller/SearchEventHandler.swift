//
// SearchEventHandler.swift
// UniversalListController
//

import Foundation

final class SearchEventHandler<ViewUpdater: ReusableViewListUpdater, Transformer: DataTransformer>: SearchBarControllerDelegate
    where
    Transformer.SectionContext == ViewUpdater.SectionContext,
    Transformer.CellContext == ViewUpdater.CellContext,
    Transformer.Data == [[City]] {

    private var viewUpdater: ViewUpdater

    private var dataProvider: CityDataProvider

    private var dataTransformer: Transformer

    init(viewUpdater: ViewUpdater, citiesProvider: CityDataProvider, dataTransformer: Transformer) {
        self.viewUpdater = viewUpdater
        dataProvider = citiesProvider
        self.dataTransformer = dataTransformer
    }

    func search(for query: String) {
        let entities = dataProvider.getData()
        let filtered = entities.first!.filter { $0.city.contains(query) || $0.description.contains(query) }
        let data = dataTransformer.transform([filtered])
        viewUpdater.update(with: data)
    }

}
