//
// Created by Eugene Kazaev on 04/02/2020.
// Copyright (c) 2020 Eugene Kazaev. All rights reserved.
//

import Foundation

protocol DataProvider {

    associatedtype Data

    associatedtype Request

    func getData(with request: Request, completion: @escaping (Result<Data, Error>) -> Void)

}

