//
//  FavoritesSubBreedsPresenter.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation

protocol FavoritesSubBreedsPresenterOutput: class {
    init(view: FavoritesSubBreedsControllerOutput, breed: String)
    
    func viewDidLoad()
    func showDogs(subBreed: String)
}

class FavoritesSubBreedsPresenter {
    
    //MARK: - Properties
    weak var view: FavoritesSubBreedsControllerOutput!
    weak var coordinator: FavoritesCoordinator?
    private var realmManager = RealmManager()
    private var breed: String
    
    //MARK: - Init
    required init(view: FavoritesSubBreedsControllerOutput, breed: String) {
        self.view = view
        self.breed = breed
    }
    
    //MARK: - Private methods
    private func getSubBreeds() {
        realmManager.observe(type: RSubBreed.self) { [weak self] (changes) in
            guard let self = self else { return }
            switch changes {
            case .initial(let results):
                let subBreeds = Array(results.filter { $0.linkToParent.first?.name == self.breed }
                .map {$0.name})
                self.view.setupDatasource(with: subBreeds)
            case .update(let results, deletions: _, insertions: _, modifications: _):
                let subBreeds = Array(results.filter { $0.linkToParent.first?.name == self.breed }
                .map {$0.name})
                self.view.setupDatasource(with: subBreeds)
            case .error(let error):
                print(error)
            }
        }
    }
}

//MARK: - Output
extension FavoritesSubBreedsPresenter: FavoritesSubBreedsPresenterOutput {
    func viewDidLoad() {
        getSubBreeds()
    }
    
    func showDogs(subBreed: String) {
        coordinator?.showDogs(breed: nil, subBreed: subBreed)
    }
}


