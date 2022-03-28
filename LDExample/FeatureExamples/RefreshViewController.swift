//
//  RefreshViewController.swift
//  LDExample
//
//  Created by Dino Gustin on 05.11.2021..
//

import UIKit
import LSCocoa
import LSData
import Combine

class RefreshViewController: RepositoriesTableViewController {

    private let dataSource = LSAPINetworkDataSource(endpoint: SearchRepositoriesEndpoint())
        .jsonDecodeMap(to: SearchRepositoriesEndpoint.Response.self)
        .outMap(with: SearchRepositoriesOutputMapper())
        .paramMap { (query: String) -> [LSApiEndpointAttribute] in
            [LSApiEndpointAttribute.addUrlParameter(key: "q", value: query)]
        }
        .refreshable(parameter: "", refreshBlockType: .cacheLast)
    
    private lazy var syncManager = dataSource.syncManager(with: LSCoreDataRepository<Repository.ManagedObject>().resultMap(with: LSToPublisherMapper()), parameter: ())
    
    
    private var cancelBag = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        let syncButton = UIBarButtonItem(title: "Sync", style: .plain, target: self, action: #selector(syncToCoreData))
        navigationItem.setRightBarButton(syncButton, animated: false)
    }
    
    override func bindData() {
        dataSource.publisher()
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { repositories in
                self.repositories = repositories
            })
            .store(in: &cancelBag)
        
        dataSource.errorPublisher
            .sink { error in
                print("request limit reached")
            }
            .store(in: &cancelBag)
        
    }
    
    @objc func syncToCoreData() {
        syncManager.sync() // Saves currently queried items to database
    }
    
    override func searchBarTextChanged(to searchText: String) {
        dataSource.refresh(with: searchText)
    }
}
