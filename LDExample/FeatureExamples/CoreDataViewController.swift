//
//  SearchViewController.swift
//  LDExample
//
//  Created by Dino Gustin on 05.11.2021..
//

import UIKit
import LSData
import LSCocoa
import Combine
import CoreData

class CoreDataViewController: RepositoriesTableViewController {

    var cancelBag = Set<AnyCancellable>()
    let dataSource = LSCoreDataRepository<Repository.ManagedObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.isHidden = true
        infoLabel.text = ""
    }
    
    override func bindData() {
        dataSource.publisher()
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { repositories in
                self.infoLabel.text = repositories.isEmpty ? "No data in DB. Go back, select refresh functionality, and sync fetched data using sync button." : ""
                self.repositories = repositories
            })
            .store(in: &cancelBag)
    }
}
