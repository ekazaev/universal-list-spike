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
    DP.Request == String,
    Transformer.Target == ListData<ViewUpdater.SectionContext, ViewUpdater.CellContext>,
    Transformer.Source == [[ListCellType<DP.Data.Element>]] {

    private var viewUpdater: ViewUpdater

    private var itemsProvider: DP

    private var dataTransformer: Transformer

    private var selectedItems: DP.Data = []

    private var filteredItems: DP.Data = []

    private var isLoading: Bool = false

    private var query: String = ""

    init(viewUpdater: ViewUpdater, citiesProvider: DP, dataTransformer: Transformer) {
        self.viewUpdater = viewUpdater
        itemsProvider = citiesProvider
        self.dataTransformer = dataTransformer
    }

    func listViewInstantiated() {
        requestData(for: query)
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
        guard !isLoading else {
            return
        }
        requestData(for: query)
    }

    func search(for query: String) {
        requestData(for: query)
    }

    private func requestData(for query: String) {
        isLoading = true
        reloadView()
        if self.query != query {
            filteredItems = []
        }
        self.query = query
        itemsProvider.getData(with: query, completion: { [weak self] result in
            self?.isLoading = false
            guard let self = self,
                let newItems = try? result.get() else {
                    return
            }
            self.filteredItems.append(contentsOf: newItems)
            self.reloadView()
        })
    }

    private func reloadView() {
        let selectedItemsState = selectedItems.map { ListCellType.dataCell($0) }
        var unselectedItemsState = itemsWithoutSelected().map { ListCellType.dataCell($0) }
        if isLoading {
            unselectedItemsState.append(.loading)
        }
        let resultItems = [
            selectedItemsState,
            unselectedItemsState
        ]
        let itemsAsListData = dataTransformer.transform(resultItems)
        viewUpdater.update(with: itemsAsListData)
    }

    private func itemsWithoutSelected() -> DP.Data {
        filteredItems.filter { !selectedItems.map { $0.cityId }.contains($0.cityId) }
    }

}
