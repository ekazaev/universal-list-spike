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

    private var filteredCities: [City] = []

    init(viewUpdater: ViewUpdater, citiesProvider: CityDataProvider, dataTransformer: Transformer) {
        self.viewUpdater = viewUpdater
        self.citiesProvider = citiesProvider
        self.dataTransformer = dataTransformer
    }

    func listViewInstantiated() {
        filteredCities = citiesProvider.getData()
        reloadView()
    }

    func didSelect(city: City) {
        let cityIndex = selectedCities.map { $0.cityId }.firstIndex(of: city.cityId)
        switch cityIndex {
        case let .some(cityIndex):
            selectedCities.remove(at: cityIndex)
        case .none:
            selectedCities.append(city)
        }
        reloadView()
    }

    func search(for query: String) {
        let cities = citiesProvider.getData()
        guard !query.isEmpty else {
            filteredCities = cities
            reloadView()
            return
        }
        filteredCities = cities.filter { $0.city.contains(query) || $0.description.contains(query) }
        reloadView()
    }

    private func reloadView() {
        let filteredWithoutSelectedCities = filteredCities.filter { !selectedCities.map { $0.cityId }.contains($0.cityId) }
        let resultCities = [selectedCities, filteredWithoutSelectedCities]
        let citiesListData = dataTransformer.transform(resultCities)
        viewUpdater.update(with: citiesListData)
    }

}
