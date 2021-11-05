//
//  SearchRepositoriesInputMapper.swift
//  LDExample
//
//  Created by Dino Gustin on 04.11.2021..
//

import Foundation
import LSData

class SearchRepositoriesOutputMapper: Mapper {

    typealias Input = SearchRepositoriesEndpoint.Response?
    typealias Output = [Repository]
    
    func map(_ input: SearchRepositoriesEndpoint.Response?) -> [Repository] {
        guard let input = input else { return [] }
        return input.items.map { item in
            Repository(id: String(item.id), name: item.name, watchers: item.watchers_count, stars: item.stargazers_count, owner: Owner(id: String(item.owner.id), name: item.owner.login))
        }
    }
}
