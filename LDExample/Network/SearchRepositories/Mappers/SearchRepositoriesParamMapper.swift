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

    typealias Input = String
    typealias Output = [LSApiEndpointAttribute]
    
    func map(_ input: String) -> [LSApiEndpointAttribute] {
        return [LSApiEndpointAttribute.addUrlParameter(key: "q", value: input)]
    }
}
