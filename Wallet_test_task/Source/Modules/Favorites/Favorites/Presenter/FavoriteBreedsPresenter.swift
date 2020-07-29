//
//  FavoriteBreedsPresenter.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoriteBreedsPresenterOutput: class {
    init(view: FavoriteBreedsControllerOutput)
    
    func viewDidLoad()
    func showSubBreeds(breed: String)
    func showDogs(breed: String)
}

class FavoriteBreedsPresenter {
    
    //MARK: - Properties
    weak var view: FavoriteBreedsControllerOutput!
    var coordinator: FavoritesCoordinator?
    
    private let realmManager = RealmManager()
    
    //MARK: - Init
    required init(view: FavoriteBreedsControllerOutput) {
        self.view = view
    }
    
    //MARK: - Private methods
    private func getFavorites() {
        realmManager.observe(type: RBreed.self) { [weak self] (changes) in
            guard let self = self else { return }
            switch changes {
            case .initial(let results):
                self.view.setupDatasource(with: Array(results))
            case .update(let results, deletions: _, insertions: _, modifications: _):
                self.view.setupDatasource(with: Array(results))
            case .error(let error):
                print(error)
            }
        }
    }
}

//MARK: - Output

extension FavoriteBreedsPresenter: FavoriteBreedsPresenterOutput {
    func viewDidLoad() {
        getFavorites()
    }
    
    func showSubBreeds(breed: String) {
        coordinator?.showSubBreeds(breed: breed)
    }
    
    func showDogs(breed: String) {
        coordinator?.showDogs(breed: breed, subBreed: nil)
    }
}
