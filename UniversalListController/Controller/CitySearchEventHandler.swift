//
// SearchEventHandler.swift
// UniversalListController
//

import Foundation

final class CitySearchEventHandler<ViewUpdater: ReusableViewListUpdater, Transformer: DataTransformer>:
    SearchBarControllerDelegate, UniversalListViewControllerDelegate, SimpleDelegateControllerEventHandler
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

    func didSelectRow(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedCities.remove(at: indexPath.item)
        case 1:
            let city = citiesWithoutSelected()[indexPath.item]
            selectedCities.append(city)
        default:
            return
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
        let resultCities = [selectedCities, citiesWithoutSelected()]
        let citiesListData = dataTransformer.transform(resultCities)
        viewUpdater.update(with: citiesListData)
    }

    private func citiesWithoutSelected() -> [City] {
        filteredCities.filter { !selectedCities.map { $0.cityId }.contains($0.cityId) }
    }

}
