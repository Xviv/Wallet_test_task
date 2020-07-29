//
//  DogsPresenter.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol DogsPresenterOutput: class {
    init(view: DogsControllerOutput)
    
    func addImageToFavorites(imageUrl: String, image: UIImage)
    func removeImageFromFavorites(imageUrl: String)
    func viewDidLoad()
}

class DogsPresenter {
    //MARK: - Properties
    weak var view: DogsControllerOutput!
    
    private let networkManager = BreedsNetworkManager()
    private let favoritesRealmManager = FavoritesRealmManager()
    private let realmManager = RealmManager()
    
    private var urls: [String] = []
    
    var breed: (breed: String, subBreed: String?)? {
        didSet {
            guard let breed = breed else { return }
            if let subBreed = breed.subBreed {
                view.setTitle(subBreed)
                getDogs(by: breed.breed, and: subBreed)
            } else {
                view.setTitle(breed.breed)
                getDogs(by: breed.breed)
            }
        }
    }
    
    //MARK: - Init
    required init(view: DogsControllerOutput) {
        self.view = view
    }
    
    //MARK: - Private methods
    private func getDogs(by breed: String, and subBreed: String) {
        networkManager.getDogs(breed: breed, subBreed: subBreed) { (result) in
            switch result {
            case .success(let urls):
                self.urls = urls
                DispatchQueue.main.async { [weak self] in
                    let favorites = self?.favoritesRealmManager.getFavorites(in: subBreed, of: RSubBreed.self)
                    self?.view.setupDatasource(with: urls, favorites: favorites ?? [])
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getDogs(by breed: String) {
        networkManager.getDogs(by: breed) { (result) in
            switch result {
            case .success(let urls):
                self.urls = urls
                DispatchQueue.main.async { [weak self] in
                    let favorites = self?.favoritesRealmManager.getFavorites(in: breed, of: RBreed.self)
                    self?.view.setupDatasource(with: urls, favorites: favorites ?? [])
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateCell(with imageURL: String) {
        guard let index = urls.firstIndex(of: imageURL) else { return }
        guard let breed = self.breed?.breed else { return }
        
        let indexPath = IndexPath(item: index, section: 0)
        
        if let subBreed = self.breed?.subBreed {
            let favorites = favoritesRealmManager.getFavorites(in: subBreed, of: RSubBreed.self)
            view.updateCell(at: indexPath, favorites: favorites)
        } else {
            let favorites = favoritesRealmManager.getFavorites(in: breed, of: RBreed.self)
            view.updateCell(at: indexPath, favorites: favorites)
        }
    }
    
    private func observeChanges() {
        guard let breed = self.breed?.breed else { return }
        if let subBreed = self.breed?.subBreed {
            realmManager.observe(type: RSubBreed.self, primaryKey: subBreed, _changes: { [weak self] (changes) in
                switch changes {
                case .initial(_): break
                    
                case .update(let results, deletions: _, insertions: _, modifications: _):
                    if let favorites = results.first?.imageURLs {
                        self?.view.setupFavorites(Array(favorites))
                    }
                case .error(let error):
                    print(error)
                }
            })
            
        } else {
            realmManager.observe(type: RBreed.self, primaryKey: breed, _changes: { [weak self] (changes) in
                switch changes {
                case .initial(_): break
                    
                case .update(let results, deletions: _, insertions: _, modifications: _):
                    if let favorites = results.first?.imageURLs {
                        self?.view.setupFavorites(Array(favorites))
                    }
                case .error(let error):
                    print(error)
                }
            })
        }
    }
}

//MARK: - Output
extension DogsPresenter: DogsPresenterOutput {
    func addImageToFavorites(imageUrl: String, image: UIImage) {
        favoritesRealmManager.write(url: imageUrl, breedName: self.breed, image: image)
        updateCell(with: imageUrl)
    }
    
    func removeImageFromFavorites(imageUrl: String) {
        guard let breed = self.breed?.breed else { return }
        if let subBreed = self.breed?.subBreed {
            _ = favoritesRealmManager.removeFromFavorites(in: subBreed, imageURL: imageUrl, of: RSubBreed.self)
        } else {
            _ = favoritesRealmManager.removeFromFavorites(in: breed, imageURL: imageUrl, of: RBreed.self)
        }
        updateCell(with: imageUrl)
    }
    
    func viewDidLoad() {
        observeChanges()
    }
}
