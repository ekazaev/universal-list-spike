//
// SearchEventHandler.swift
// UniversalListController
//

import Foundation
import Shared
import UniversalList
import UniversalList

final class GenericSearchEventHandler<Entity, ViewUpdater: UniversalListUpdater, DP: PageableDataProvider, Transformer: DataTransformer>:
    SearchContainerViewControllerEventHandler,
    SimpleDelegateControllerEventHandler,
    NextPageEventHandler,
    DataLoadingSource,
    UniversalListViewControllerEventHandler
    where
    Entity: Identifiable,
    DP.Data == [Entity],
    DP.Request == String,
    Transformer.Target == ListData<ViewUpdater.SectionContext, ViewUpdater.CellContext>,
    Transformer.Source == [[ListCellType<DP.Data.Element>]] {

    weak var resultDelegate: SearchResultStateDelegate?

    private(set) var isDataLoading: Bool = false

    private var isFullyLoaded = false

    private var viewUpdater: ViewUpdater

    private var itemsProvider: DP

    private var dataTransformer: Transformer

    private var selectedItems: DP.Data = []

    private var filteredItems: DP.Data = []

    private var query: String = ""

    init(viewUpdater: ViewUpdater, citiesProvider: DP, dataTransformer: Transformer) {
        self.viewUpdater = viewUpdater
        itemsProvider = citiesProvider
        self.dataTransformer = dataTransformer
    }

    func listViewInstantiated() {
        reloadView()
        search(for: query)
    }

    func didSelectRow(at indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedItems.remove(at: indexPath.item)
        case 1:
            let items = itemsWithoutSelected()
            guard items.count > indexPath.item else {
                return
            }
            let city = items[indexPath.item]
            selectedItems.append(city)
        default:
            return
        }
        reloadView()
    }

    func requestNewPage() {
        guard !isDataLoading, !isFullyLoaded else {
            return
        }
        isDataLoading = true
        reloadView()
        let query = self.query
        itemsProvider.getNextPage { [weak self] result in
            guard query == self?.query else {
                return
            }
            self?.handleDataLoad(result: result)
        }
    }

    func search(for query: String) {
        let isNewRequest = self.query != query
        self.query = query
        guard isNewRequest else {
            return
        }
        isDataLoading = true
        reloadView()
        if isNewRequest {
            isFullyLoaded = false
            filteredItems = []
        }
        resultDelegate?.searchResultStateChanged(to: query.isEmpty ? .initial : .someResults)
        itemsProvider.getData(with: query, completion: { [weak self] result in
            self?.handleDataLoad(result: result)
        })
    }

    private func handleDataLoad(result: Result<DP.Data, Error>) {
        isDataLoading = false
        guard let newItems = try? result.get() else {
            return
        }
        isFullyLoaded = newItems.isEmpty
        filteredItems.append(contentsOf: newItems)

        resultDelegate?.searchResultStateChanged(to: query.isEmpty ? .initial : filteredItems.isEmpty ? .noResults : .someResults)

        reloadView()
    }

    private func reloadView() {
        let selectedCells = selectedItems.map {
            ListCellType.dataCell($0)
        }
        var unselectedCells = itemsWithoutSelected().map {
            ListCellType.dataCell($0)
        }

        if isDataLoading {
            unselectedCells.append(.loadingCell)
        }

        let resultItems = [
            selectedCells,
            unselectedCells
        ]
        let itemsAsListData = dataTransformer.transform(resultItems)
        viewUpdater.update(with: itemsAsListData)
    }

    private func itemsWithoutSelected() -> DP.Data {
        filteredItems.filter { !selectedItems.map { $0.id }.contains($0.id) }
    }

}