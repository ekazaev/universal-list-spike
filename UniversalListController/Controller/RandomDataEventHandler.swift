//
// RandomDataEventHandler.swift
// UniversalListController
//

import Foundation

class RandomDataEventHandler: UniversalListViewControllerEventHandler {

    private weak var view: ViewController?
    
    private var timer: Timer!
    
    init(view: ViewController) {
        self.view = view
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            let cities = CityDataMock.cities.shuffled()
            self?.view?.update(with: cities)
        }
    }

    
}
