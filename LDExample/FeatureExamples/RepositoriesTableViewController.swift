//
//  RepositoriesTableViewController.swift
//  LDExample
//
//  Created by Dino Gustin on 25.03.2022..
//

import UIKit
import LSCocoa
import LSData
import Combine

/// Generic ViewController designed to show a list of Repositories
class RepositoriesTableViewController: UIViewController {
    
    public lazy var searchBar = UISearchBar()
    public lazy var tableView = UITableView()
    public lazy var infoLabel = UILabel()

    var repositories = [Repository]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        bindData()
    }

    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 6.0).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6.0).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12.0).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoLabel.textColor = .black
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.text = "GitHub has a limit for requests per minute (about 10?). If no data is outputted when searching, this limit was reached."
    }
    
    func bindData() {
        
    }
    
    func searchBarTextChanged(to searchText: String) {
        
    }
}

extension RepositoriesTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarTextChanged(to: searchText)
    }
}

extension RepositoriesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        cell.textLabel?.text = repositories[indexPath.row].name
        return cell
    }
}

extension RepositoriesTableViewController: UITableViewDelegate {
    
}
