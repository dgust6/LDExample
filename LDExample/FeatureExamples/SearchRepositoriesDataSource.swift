//
//  SearchRepositoriesDataSource.swift
//  LDExample
//
//  Created by Dino Gustin on 25.03.2022..
//

import Foundation
import Combine
import LSCocoa
import LSData

class SearchRepositoriesDataSource: DataSource {
    
    typealias Output = [Repository]
    typealias Parameter = String
    typealias OutputError = LSNetworkError
    
    private let dataSource: LSAnyDataSource<[Repository], String, LSNetworkError>
    
    init() {
        dataSource = LSAPINetworkDataSource(endpoint: SearchRepositoriesEndpoint())
            .jsonDecodeMap(to: SearchRepositoriesEndpoint.Response.self)
            .outMap(with: SearchRepositoriesOutputMapper())
            .paramMap(with: SearchRepositoriesParamMapper())
            .erase()
    }
    
    func publisher(parameter: String) -> AnyPublisher<[Repository], LSNetworkError> {
        dataSource.publisher(parameter: parameter)
    }
}
