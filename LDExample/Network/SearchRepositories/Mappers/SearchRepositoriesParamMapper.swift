//
//  SearchRepositoriesMapper.swift
//  LDExample
//
//  Created by Dino Gustin on 04.11.2021..
//

import Foundation
import LSCocoa
import LSData

class SearchRepositoriesParamMapper: Mapper {

    typealias Input = [SearchRepositoriesEndpoint.Attributes]?
    typealias Output = [LSApiEndpointAttribute]
    
    func map(_ input: [SearchRepositoriesEndpoint.Attributes]?) -> [LSApiEndpointAttribute] {
        guard let input = input else { return [] }
        return input.map { item in
            switch item {
            case .query(let query):
                return .addUrlParameter(key: "q", value: query)
            }
        }
    }
}
