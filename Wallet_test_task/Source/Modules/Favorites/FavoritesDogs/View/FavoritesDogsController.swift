//
//  FavoritesDogsController.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol FavoritesDogsControllerOutput: class {
    func setupDatasource(with data: CommonBreedProtocol)
    func showShareController(with image: UIImage)
    func setTitle(_ title: String)
}

class FavoritesDogsController: UIViewController {
    
    //MARK: - Properties
    var presenter: FavoritesDogsPresenterOutput?
    private let datasourceAndDelegate = FavoritesDogsDatasourceAndDelegate()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    //MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FavoritesDogsCell.self, forCellWithReuseIdentifier: "cell")
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
    
    private func setupNavigationBar() {
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonAction))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    //MARK: - Actions
    
    @objc func shareButtonAction() {
        presenter?.shareButtonTapped()
    }
    
}

//MARK: - Output

extension FavoritesDogsController: FavoritesDogsControllerOutput {
    func setupDatasource(with data: CommonBreedProtocol) {
        datasourceAndDelegate.breed = data
        collectionView.reloadData()
    }
    
    func showShareController(with image: UIImage) {
        let image = image

        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
}
