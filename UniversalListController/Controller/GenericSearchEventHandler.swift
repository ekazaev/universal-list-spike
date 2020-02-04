//
// SearchEventHandler.swift
// UniversalListController
//

import Foundation

protocol GenericSearchEventHandlerDelegate: AnyObject {

    func searchResultStateChanged(to state: GenericSearchEventHandlerState)

}

enum GenericSearchEventHandlerState {
    case initial
    case someResults
    case noResults
}

final class GenericSearchEventHandler<Entity, ViewUpdater: ReusableViewListUpdater, DP: DataProvider, Transformer: DataTransformer>:
    SearchContainerViewControllerEventHandler,
    UniversalListViewControllerDelegate,
    SimpleDelegateControllerEventHandler,
    NextPageEventHandler,
    DataLoadingStateHandler
    where
    Entity: Identifiable,
    DP.Data == [Entity],
    DP.Request == String,
    Transformer.Target == ListData<ViewUpdater.SectionContext, ViewUpdater.CellContext>,
    Transformer.Source == [[ListCellType<DP.Data.Element>]] {

    weak var delegate: GenericSearchEventHandlerDelegate?

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
        guard !isDataLoading else {
            return
        }
        requestData(for: query)
    }

    func search(for query: String) {
        requestData(for: query)
    }

    private func requestData(for query: String) {
        let isNewRequest = self.query != query
        self.query = query
        guard isNewRequest || !isFullyLoaded else {
            return
        }
        isDataLoading = true
        reloadView()
        if isNewRequest {
            isFullyLoaded = false
            filteredItems = []
        }
        delegate?.searchResultStateChanged(to: query.isEmpty ? .initial : .someResults)
        itemsProvider.getData(with: query, completion: { [weak self] result in
            self?.isDataLoading = false
            guard let self = self,
                let newItems = try? result.get() else {
                    return
            }
            self.isFullyLoaded = newItems.isEmpty
            self.filteredItems.append(contentsOf: newItems)

            self.delegate?.searchResultStateChanged(to: query.isEmpty ? .initial : self.filteredItems.isEmpty ? .noResults : .someResults)

            self.reloadView()
        })
    }

    private func reloadView() {
        let selectedItemsState = selectedItems.map { ListCellType.dataCell($0) }
        var unselectedItemsState = itemsWithoutSelected().map { ListCellType.dataCell($0) }

        if isDataLoading {
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
        filteredItems.filter {
            !selectedItems.map {
                $0.id
            }.contains($0.id)
        }
    }

}
