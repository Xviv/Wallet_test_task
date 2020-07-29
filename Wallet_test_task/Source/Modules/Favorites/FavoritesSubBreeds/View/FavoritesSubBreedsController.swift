//
//  FavoritesSubBreedsController.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol FavoritesSubBreedsControllerOutput: class {
    func setupDatasource(with data: [String])
    func deleteRows(at indexPath: [IndexPath], data: [String])
    func updateRows(at indexPath: [IndexPath], data: [String])
    func insertRows(at indexPath: [IndexPath], data: [String])
}

class FavoritesSubBreedsController: UIViewController {
    
    //MARK: - Properties
    var presenter: FavoritesSubBreedsPresenterOutput?
    let datasourceAndDelegate = FavoritesSubBreedsDatasourceAndDelegate()
    
    //MARK: - Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    //MARK: - Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.datasourceAndDelegate.controller = self
        tableView.dataSource = self.datasourceAndDelegate
        tableView.delegate = self.datasourceAndDelegate
        
        return tableView
    }()
    
    //MARK: - UI Setup
    private func setupUI() {
        title = "Breeds"
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - Output

extension FavoritesSubBreedsController: FavoritesSubBreedsControllerOutput {
    func setupDatasource(with data: [String]) {
        DispatchQueue.main.async { [weak self] in
            self?.datasourceAndDelegate.breeds = data
            self?.tableView.reloadData()
        }
    }
    
    func deleteRows(at indexPath: [IndexPath], data: [String]) {
        indexPath.forEach { [weak self] in
            self?.datasourceAndDelegate.breeds.remove(at: $0.row)
        }
        tableView.deleteRows(at: indexPath, with: .automatic)
    }
    
    func updateRows(at indexPath: [IndexPath], data: [String]) {
        indexPath.enumerated().forEach { [weak self] _ in
            self?.datasourceAndDelegate.breeds = data
        }
        tableView.reloadRows(at: indexPath, with: .automatic)
    }
    
    func insertRows(at indexPath: [IndexPath], data: [String]) {
        indexPath.enumerated().forEach { [weak self] _ in
            self?.datasourceAndDelegate.breeds = data
        }
        tableView.insertRows(at: indexPath, with: .automatic)
    }
}
