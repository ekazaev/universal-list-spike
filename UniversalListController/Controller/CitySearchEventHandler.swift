//
// SearchEventHandler.swift
// UniversalListController
//

import Foundation

final class CitySearchEventHandler<ViewUpdater: ReusableViewListUpdater, DP: DataProvider, Transformer: DataTransformer>:
    SearchBarControllerDelegate,
    UniversalListViewControllerDelegate,
    SimpleDelegateControllerEventHandler,
    NextPageEventHandler
    where
    DP.Data == [City],
    Transformer.Target == ListData<ViewUpdater.SectionContext, ViewUpdater.CellContext>,
    Transformer.Source == [DP.Data] {

    private var viewUpdater: ViewUpdater

    private var itemsProvider: DP

    private var dataTransformer: Transformer

    private var selectedItems: DP.Data = []

    private var filteredItems: DP.Data = []

    init(viewUpdater: ViewUpdater, citiesProvider: DP, dataTransformer: Transformer) {
        self.viewUpdater = viewUpdater
        self.itemsProvider = citiesProvider
        self.dataTransformer = dataTransformer
    }

    func listViewInstantiated() {
        filteredItems = itemsProvider.getData()
        reloadView()
    }

    func didSelectRow(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedItems.remove(at: indexPath.item)
        case 1:
            let city = itemsWithoutSelected()[indexPath.item]
            selectedItems.append(city)
        default:
            return
        }
        reloadView()
    }

    func requestNewPage() {
        filteredItems.append(contentsOf: itemsProvider.getData())
        reloadView()
    }

    func search(for query: String) {
        let cities = itemsProvider.getData()
        guard !query.isEmpty else {
            filteredItems = cities
            reloadView()
            return
        }
        filteredItems = cities.filter { $0.city.contains(query) || $0.description.contains(query) }
        reloadView()
    }

    private func reloadView() {
        let resultItems = [selectedItems, itemsWithoutSelected()]
        let itemsAsListData = dataTransformer.transform(resultItems)
        viewUpdater.update(with: itemsAsListData)
    }

    private func itemsWithoutSelected() -> DP.Data {
        filteredItems.filter { !selectedItems.map { $0.cityId }.contains($0.cityId) }
    }

}
