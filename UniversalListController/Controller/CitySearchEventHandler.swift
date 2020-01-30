//
// SearchEventHandler.swift
// UniversalListController
//

import Foundation

final class CitySearchEventHandler<ViewUpdater: ReusableViewListUpdater, Transformer: DataTransformer>:
    SearchBarControllerDelegate, UniversalListViewControllerDelegate, SearchListDelegateEventHandler
    where
    Transformer.Target == ListData<ViewUpdater.SectionContext, ViewUpdater.CellContext>,
    Transformer.Source == [[City]] {

    private var viewUpdater: ViewUpdater

    private var citiesProvider: CityDataProvider

    private var dataTransformer: Transformer

    private var selectedCities: [City] = []

    init(viewUpdater: ViewUpdater, citiesProvider: CityDataProvider, dataTransformer: Transformer) {
        self.viewUpdater = viewUpdater
        self.citiesProvider = citiesProvider
        self.dataTransformer = dataTransformer
    }

    func listViewInstantiated() {
        search(for: "")
    }

    func didSelect(city: City) {
        let cityIndex = selectedCities.map { $0.cityId }.firstIndex(of: city.cityId)
        switch cityIndex {
        case let .some(cityIndex):
            selectedCities.remove(at: cityIndex)
        case .none:
            selectedCities.append(city)
        }
    }

    func search(for query: String) {
        let cities = citiesProvider.getData()
        guard !query.isEmpty else {
            let citiesList = dataTransformer.transform([cities])
            viewUpdater.update(with: citiesList)
            return
        }
        let filtered = cities.filter { $0.city.contains(query) || $0.description.contains(query) }
        let data = dataTransformer.transform([filtered])
        viewUpdater.update(with: data)
    }

}
