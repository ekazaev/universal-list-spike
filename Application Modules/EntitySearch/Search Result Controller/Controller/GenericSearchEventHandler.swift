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
    DP.Request == String,
    DP.Data == [Entity],
    Transformer.Input == [[ListCellType<Entity, LoadingAccessory>]],
    Transformer.Output == ListData<ViewUpdater.SectionContext, ViewUpdater.CellContext> {

    private enum GenericSearchEventHandlerState {

        case idle

        case loading

        case loadingNextPate

        case fullyLoaded

        var isLoading: Bool {
            return self == .loading || self == .loadingNextPate
        }

    }

    weak var resultDelegate: SearchResultStateDelegate?

    var shouldRequestNextPage: Bool {
        return state == .idle
    }

    private var state: GenericSearchEventHandlerState = .idle

    private var viewUpdater: ViewUpdater

    private var itemsProvider: DP

    private var dataTransformer: Transformer

    private var selectedItems: DP.Data = []

    private var filteredItems: DP.Data = []

    private var query: String = ""

    private var resultState: SearchResultState {
        return query.isEmpty ? .initial : (filteredItems.isEmpty && !state.isLoading) ? .noResults : .someResults
    }

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

    func search(for query: String) {
        let isNewRequest = self.query != query
        self.query = query
        guard isNewRequest else {
            return
        }
        state = .loading
        reloadView()
        resultDelegate?.searchResultStateChanged(to: resultState)
        let query = self.query
        itemsProvider.getData(with: query, completion: { [weak self] result in
            guard query == self?.query else {
                return
            }
            if isNewRequest {
                self?.filteredItems = []
            }
            self?.handleDataLoad(result: result)
        })
    }

    func requestNewPage() {
        guard shouldRequestNextPage else {
            return
        }
        state = .loadingNextPate
        reloadView()
        let query = self.query
        itemsProvider.getNextPage { [weak self] result in
            guard query == self?.query else {
                return
            }
            self?.handleDataLoad(result: result)
        }
    }

    private func handleDataLoad(result: Result<DP.Data, Error>) {
        guard let newItems = try? result.get() else {
            state = .idle
            return
        }
        filteredItems.append(contentsOf: newItems)
        reloadView()

        state = newItems.isEmpty ? .fullyLoaded : .idle
        resultDelegate?.searchResultStateChanged(to: resultState)
        reloadView()
    }

    private func reloadView() {
        let selectedCells = selectedItems.map { ListCellType<Entity, LoadingAccessory>.dataCell($0) }
        var unselectedCells = itemsWithoutSelected().map { ListCellType<Entity, LoadingAccessory>.dataCell($0) }

        if state.isLoading {
            if unselectedCells.isEmpty {
                unselectedCells.append(.accessoryCell(.pleaseWait))
            }
            if state == .loadingNextPate {
                unselectedCells.append(.accessoryCell(.loadingMore))
            }
        }

        let resultItems = [
            selectedCells,
            unselectedCells
        ]
        let itemsAsListData = dataTransformer.transform(resultItems)
        viewUpdater.update(with: itemsAsListData)
    }

    private func itemsWithoutSelected() -> DP.Data {
        let selectedIds = selectedItems.map { $0.id }
        return filteredItems.filter { return !selectedIds.contains($0.id) }
    }

}
