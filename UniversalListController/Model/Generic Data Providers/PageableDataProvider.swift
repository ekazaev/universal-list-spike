//
// Created by Eugene Kazaev on 04/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation

protocol PageableDataProvider: DataProvider {

    func getNextPage(completion: @escaping (Result<Data, Error>) -> Void)

}
