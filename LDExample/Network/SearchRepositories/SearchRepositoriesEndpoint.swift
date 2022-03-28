//
//  SearchRepositoriesEndpoint.swift
//  LDExample
//
//  Created by Dino Gustin on 04.11.2021..
//

import Foundation
import LSData
import LSCocoa

struct SearchRepositoriesEndpoint: ApiEndpoint {
        
    var baseUrl: URL = NetworkConfiguration.baseUrl
    
    var path: String? = "/search/repositories"
            
    var headers = ["Accept" : "application/vnd.github.v3+json"]
}

extension SearchRepositoriesEndpoint {
    struct Response: Decodable {
        let total_count: Int
        let items: [RepositoryNetworkModel]
    }
}
