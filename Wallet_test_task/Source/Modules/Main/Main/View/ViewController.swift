//
//  ViewController.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol MainViewOutput: BaseViewControllerOutput {
    func setupDatasource(with data: [(breed: String, subBreeds: [String])])
}

class MainViewController: BaseViewController {
    
    //MARK: - Properties
    var presenter: MainPresenterOutput?
    private var datasourceAndDelegate = MainDatasourceAndDelegate()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupRefreshControl()
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
    
    let refreshControl = UIRefreshControl()
    
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
    
    private func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
    }
    
    //MARK: - Actions
    
    @objc func refreshControlAction(_ sender: UIRefreshControl) {
        presenter?.refreshTableView()
        sender.endRefreshing()
    }
}

//MARK: - Output

extension MainViewController: MainViewOutput {
    func setupDatasource(with data: [(breed: String, subBreeds: [String])]) {
        DispatchQueue.main.async { [weak self] in
            self?.datasourceAndDelegate.breeds = data
            self?.tableView.reloadData()
        }
    }
}

