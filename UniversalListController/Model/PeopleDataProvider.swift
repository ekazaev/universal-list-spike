//
// Created by Eugene Kazaev on 03/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation

final class PeopleDataProvider: DataProvider {

    private var requestingQuery: String?

    func getData(with query: String, completion: @escaping (Result<[Person], Error>) -> Void) {
        delay {
            guard self.requestingQuery == nil || self.requestingQuery != query else {
                return
            }
            defer {
                self.requestingQuery = nil
            }
            self.requestingQuery = query
            let people = PeopleDataMock.cities
            guard !query.isEmpty else {
                return completion(.success(people))
            }
            let filteredPeople = people.filter { $0.city.contains(query) || $0.description.contains(query) }
            completion(.success(filteredPeople))
        }
    }

    private func delay(completion: @escaping () -> Void) {
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .seconds(Int.random(in: 0...3))
        mainQueue.asyncAfter(deadline: deadline) { completion() }
    }

}
