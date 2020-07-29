//
//  SubBreedsViewController.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol SubBreedsControllerOutput: class {
    func setupDatasource(with data: [String])
}

class SubBreedsViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: SubBreedsPresenterOutput?
    private let datasourceAndDelegate = SubBreedsDatasourceAndDelegate()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
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

extension SubBreedsViewController: SubBreedsControllerOutput {
    func setupDatasource(with data: [String]) {
        DispatchQueue.main.async { [weak self] in
            self?.datasourceAndDelegate.breeds = data
            self?.tableView.reloadData()
        }
    }
}
