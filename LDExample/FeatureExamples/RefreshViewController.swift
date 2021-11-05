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

class RefreshViewController: UIViewController {
    
    public lazy var searchBar = UISearchBar()
    public lazy var tableView = UITableView()
    
    var cancelBag = Set<AnyCancellable>()
    let repository = LSCoreDataRepository<RepositoryManagedObject>(stack: try! LSCoreDataStack(modelName: "Model"))
    let dataSource = LSAPINetworkDataSource(endpoint: SearchRepositoriesEndpoint())
        .jsonDecodeMap(to: SearchRepositoriesEndpoint.Response.self)
        .outMap(with: SearchRepositoriesOutputMapper())
        .paramMap(with: SearchRepositoriesParamMapper())
        .refreshable(autoRefresh: false)
        
    var repositories = [Repository]()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self

        dataSource.publisher()
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { repositories in
                self.repositories = repositories
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            .store(in: &cancelBag)
    }
    
    override func loadView() {
        super.loadView()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        view.backgroundColor = .white
    }
}

extension RefreshViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource.refresh(with: [.query(searchText)])
    }
}

extension RefreshViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = repositories[indexPath.row].name
        return cell
    }
}

extension RefreshViewController: UITableViewDelegate {
    
}
