//
//  DogsViewController.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol DogsControllerOutput: class {
    func setupDatasource(with data: [String], favorites: [String])
    func updateCell(at indexPath: IndexPath, favorites: [String])
    func setupFavorites(_ data: [String])
    func setTitle(_ title: String)
}

class DogsViewController: UIViewController {
    
    //MARK: - Properties
    var presenter: DogsPresenterOutput?
    private let datasourceAndDelegate = DogsDatasourceAndDelegate()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    //MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(DogsCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        self.datasourceAndDelegate.controller = self
        collectionView.dataSource = self.datasourceAndDelegate
        collectionView.delegate = self.datasourceAndDelegate
        
        return collectionView
    }()
    
    //MARK: - UI Setup
    private func setupUI() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

//MARK: - Output
extension DogsViewController: DogsControllerOutput {
    func setupDatasource(with data: [String], favorites: [String]) {
        DispatchQueue.main.async { [weak self] in
            self?.datasourceAndDelegate.urls = data
            self?.datasourceAndDelegate.favorites = favorites
            self?.collectionView.reloadData()
        }
    }
    
    func updateCell(at indexPath: IndexPath, favorites: [String]) {
        datasourceAndDelegate.favorites = favorites
        collectionView.reloadItems(at: [indexPath])
    }
    
    func setupFavorites(_ data: [String]) {
        datasourceAndDelegate.favorites = data
        collectionView.reloadData()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
}
