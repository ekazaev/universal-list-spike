//
// SearchEventHandler.swift
// UniversalListController
//

import Foundation

final class CitySearchEventHandler<ViewUpdater: ReusableViewListUpdater, Transformer: DataTransformer>:
    SearchBarControllerDelegate, UniversalListViewControllerDelegate, SearchListDelegateEventHandler
    where
    Transformer.SectionContext == ViewUpdater.SectionContext,
    Transformer.CellContext == ViewUpdater.CellContext,
    Transformer.Data == [[City]] {

    private var viewUpdater: ViewUpdater

    private var dataProvider: CityDataProvider

    private var dataTransformer: Transformer

    private var selectedCityIds: [Int] = []

    init(viewUpdater: ViewUpdater, citiesProvider: CityDataProvider, dataTransformer: Transformer) {
        self.viewUpdater = viewUpdater
        dataProvider = citiesProvider
        self.dataTransformer = dataTransformer
    }

    func listViewInstantiated() {
        search(for: "")
    }

    func didSelect(city: City) {
        switch selectedCityIds.contains(city.cityId) {
        case true:
            selectedCityIds.removeFirst(city.cityId)
        case false:
            selectedCityIds.append(city.cityId)
        }
    }

    func search(for query: String) {
        let entities = dataProvider.getData()
        guard !query.isEmpty else {
            let data = dataTransformer.transform(entities)
            viewUpdater.update(with: data)
            return
        }
        let filtered = entities.first!.filter { $0.city.contains(query) || $0.description.contains(query) }
        let data = dataTransformer.transform([filtered])
        viewUpdater.update(with: data)
    }

}
