//
// Created by Eugene Kazaev on 03/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation

final class PeopleDataProvider: DataProvider {

    func getData(with query: String, completion: @escaping (Result<[Person], Error>) -> Void) {
        delay {
            let people = PeopleDataMock.people.sorted(by: { $0.name < $1.name} )
            guard !query.isEmpty else {
                return completion(.success(people))
            }
            let filteredPeople = people.filter {
                $0.name.lowercased().contains(query.lowercased()) || $0.description.lowercased().contains(query.lowercased())
            }
            completion(.success(filteredPeople))
        }
    }

    private func delay(completion: @escaping () -> Void) {
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .seconds(Int.random(in: 0...2))
        mainQueue.asyncAfter(deadline: deadline) {
            completion()
        }
    }

}
