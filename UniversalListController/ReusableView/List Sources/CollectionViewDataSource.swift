//
// CollectionViewDataSource.swift
// UniversalListController
//

import Foundation
import UIKit

class CollectionViewDataSource<SectionContext, CellContext, VS: ViewSource>: NSObject, UICollectionViewDataSource
    where
    VS.View: UICollectionView,
    CellContext: CellSource,
    CellContext.Cell: UICollectionViewCell {

    var data: ListData<SectionContext, CellContext> = ListData(sections: [])

    private let viewSource: VS
    private let cellDequeuer: CollectionReusableCellDequeuer<VS>

    init(viewSource: VS) {
        self.viewSource = viewSource
        cellDequeuer = CollectionReusableCellDequeuer(viewSource: viewSource)

        super.init()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.sections[section].cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellBuilder = data.sections[indexPath.section].cells[indexPath.item]
        let cell = cellBuilder.context.getView(with: DequeuerBuilder(using: cellDequeuer, with: indexPath))
        return cell
    }

}
