//
//  ViewController.swift
//  LDExample
//
//  Created by Dino Gustin on 03.11.2021..
//

import UIKit

enum SupportedVCs {
    case searchVC
    case refreshVC
    case exampleVC
}

class ViewController: UIViewController {
    
    var items: [(title: String, vc: SupportedVCs)] = [("Core Data", .searchVC), ("Refresh", .refreshVC)]
    lazy var tableView = UITableView()
    
    override func loadView() {
        super.loadView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.largeContentTitle = item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let viewController: UIViewController
        switch item.vc {
        case .refreshVC:
            viewController = RefreshViewController()
        case .searchVC:
            viewController = CoreDataViewController()
        case .exampleVC:
            viewController = CoreDataViewController()
        }
        self.navigationController?.pushViewController(viewController, animated: true)

    }
}
