//
// Created by Eugene Kazaev on 03/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation
import DifferenceKit

struct Person: Identifiable {

    var id: Int

    var name: String

    var description: String

}

extension Person: Differentiable {

    public var differenceIdentifier: Int { return id }

    public func isContentEqual(to source: Person) -> Bool {
        return id == source.id
    }

}

enum PeopleDataMock {

    static var people = [
        Person(id: 1, name: "Eugene Kazaev", description: "IOS Developer"),
        Person(id: 2, name: "Lucas Baptista", description: "Team lead"),
        Person(id: 3, name: "Edgar Lopes", description: "IOS Developer"),
        Person(id: 4, name: "Steve Jobs", description: "Deadmen"),
        Person(id: 5, name: "Alexandra Stamato", description: "Garbage Collector Adjuster"),
        Person(id: 6, name: "Jorge Lucas", description: "Director"),
        Person(id: 7, name: "Capitan America", description: "Superhero"),
        Person(id: 8, name: "Leonardo DiCaprio", description: "Actor"),
        Person(id: 9, name: "Kylie Minogue", description: "Singer"),
        Person(id: 10, name: "Julia Roberts", description: "Actress"),
        Person(id: 11, name: "George Bush", description: "Weirdo"),
        Person(id: 12, name: "Donald Trump", description: "Dickhead"),
        Person(id: 13, name: "Vladimir Putin", description: "Dickhead"),
        Person(id: 14, name: "Boris Johnson", description: "Dickhead"),
        Person(id: 15, name: "Barack Obama", description: "Dickhead * 0.5"),
        Person(id: 16, name: "Cathal Murphy", description: "Designer"),
        Person(id: 17, name: "Johny Ive", description: "Designer"),
        Person(id: 18, name: "Angela Merkel", description: "Dickhead * 0.3"),
        Person(id: 19, name: "Margaret Mitchel", description: "Writer"),
    ]

}
