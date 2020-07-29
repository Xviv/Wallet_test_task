//
//  FavoritesPresenter.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit
import RealmSwift

protocol FavoritesDogsPresenterOutput: class  {
    init(view: FavoritesDogsControllerOutput, breed: String?, subBreed: String?)
    func viewDidLoad()
    func removeImageFromFavorites(imageUrl: String)
    func getCurrentImageUrl(url: String)
    func shareButtonTapped()
}

class FavoritesDogsPresenter {
    
    //MARK: - Properties
    weak var view: FavoritesDogsControllerOutput!
    private let realmManager = RealmManager()
    private var favoritesRealmManager = FavoritesRealmManager()
    private var breed: String?
    private var subBreed: String?
    private var currentImageUrl: String?
    
    var coordinator: FavoritesCoordinator?
    
    //MARK: - Init
    required init(view: FavoritesDogsControllerOutput, breed: String?, subBreed: String?) {
        self.view = view
        self.breed = breed
        self.subBreed = subBreed
        view.setTitle((breed != nil ? breed : subBreed) ?? "")
    }
    
    //MARK: - Private methods
    private func getLocalImagesUrls() {
        if let breed = breed {
            observeBreed(breed)
        } else if let subBreed = subBreed {
            observeSubBreed(subBreed)
        }
    }
    
    private func observeBreed(_ breed: String) {
        realmManager.observe(type: RBreed.self, primaryKey: breed) {[weak self] (changes) in
            switch changes {
            case .initial(let results):
                guard let breed = results.first else { return }
                self?.currentImageUrl = breed.localURLs.first
                self?.view.setupDatasource(with: breed)
            case .update(let results, deletions: _, insertions: _, modifications: _):
                guard let breed = results.first else {
                    self?.view.setupDatasource(with: nil)
                    self?.coordinator?.pop()
                    return
                }
                self?.view.setupDatasource(with: breed)
            case .error(let error):
                print(error)
            }
        }

    }
    
    private func observeSubBreed(_ subBreed: String) {
        realmManager.observe(type: RSubBreed.self, primaryKey: subBreed) {[weak self] (changes) in
            switch changes {
            case .initial(let results):
                guard let breed = results.first else { return }
                self?.currentImageUrl = breed.localURLs.first
                self?.view.setupDatasource(with: breed)
            case .update(let results, deletions: _, insertions: _, modifications: _):
                guard let breed = results.first else {
                    self?.view.setupDatasource(with: nil)
                    self?.coordinator?.pop()
                    return
                }
                self?.view.setupDatasource(with: breed)
            case .error(let error):
                print(error)
            }
        }
    }
}

//MARK: - Output

extension FavoritesDogsPresenter: FavoritesDogsPresenterOutput {
    func viewDidLoad() {
        getLocalImagesUrls()
    }
    
    func removeImageFromFavorites(imageUrl: String) {
        if let breed = breed, breed != "" {
            _ = favoritesRealmManager.removeFromFavorites(in: breed, imageURL: imageUrl, of: RBreed.self) { [weak self] in
                self?.realmManager.removeToken()
                self?.coordinator?.pop()
            }
        } else if let subBreed = subBreed, subBreed != "" {
            _ = favoritesRealmManager.removeFromFavorites(in: subBreed, imageURL: imageUrl, of: RSubBreed.self) { [weak self] in
                self?.realmManager.removeToken()
                self?.coordinator?.pop()
            }
        }
    }
    
    func getCurrentImageUrl(url: String) {
        self.currentImageUrl = url
    }
    
    func shareButtonTapped() {
        guard let url = URL(string: currentImageUrl ?? "") else { return }
        do {
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else { return }
            self.view.showShareController(with: image)
        } catch {
            print(error)
        }
        
    }
}
