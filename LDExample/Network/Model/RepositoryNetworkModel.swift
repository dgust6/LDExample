//
//  RepositoryNetworkModel.swift
//  LDExample
//
//  Created by Dino Gustin on 04.11.2021..
//

import Foundation

struct RepositoryNetworkModel: Codable {
    let id: Int
    let node_id: String
    let name: String
    let stargazers_count: Int
    let watchers_count: Int
    let owner: OwnerNetworkModel
}
