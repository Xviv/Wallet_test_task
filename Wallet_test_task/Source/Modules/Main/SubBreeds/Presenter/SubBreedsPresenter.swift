//
//  SubBreedsPresenter.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation

protocol SubBreedsPresenterOutput: class {
    init(view: SubBreedsControllerOutput)
    func showDogs(for subBreed: String)
}

class SubBreedsPresenter {
    
    //MARK: - Properties
    weak var view: SubBreedsControllerOutput!
    
    var coordinator: MainCoordinator?
    
    var breed: (breed: String, subBreeds: [String])? {
        didSet {
            guard let breed = breed else { return }
            view.setupDatasource(with: breed.subBreeds)
        }
    }
    
    //MARK: - Init
    required init(view: SubBreedsControllerOutput) {
        self.view = view
    }
}

//MARK: - Output
extension SubBreedsPresenter: SubBreedsPresenterOutput {
    func showDogs(for subBreed: String) {
        coordinator?.showDogs(breed: (breed!.breed, subBreed))
    }
}
