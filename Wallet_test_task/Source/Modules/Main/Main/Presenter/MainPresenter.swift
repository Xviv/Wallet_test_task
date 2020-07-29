//
//  MainPresenter.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import Foundation

protocol MainPresenterOutput: class {
    init(view: MainViewOutput)
    
    func viewDidLoad()
    func showSubBreeds(_ breed: (breed: String, subBreeds: [String]))
    func showDogs(for breed: String)
    func refreshTableView()
}

class MainPresenter {
    
    //MARK: - Properties
    weak var view: MainViewOutput!
    var coordinator: MainCoordinator?
    
    private let networkManager = BreedsNetworkManager()
    
    //MARK: - Init
    required init(view: MainViewOutput) {
        self.view = view
    }
    
    //MARK: - Private methods
    private func getAllBreeds() {
        self.view.showActivityIndicator()
        
        networkManager.getAllBreeds { (result) in
            switch result {
            case .success(let breeds):
                self.view?.setupDatasource(with: breeds.resultTuple)
            case .failure( let error):
                self.view?.showAlert(message: error)
            }
            self.view.hideActivityIndicator()
        }
    }
    
    
}

//MARK: - Output
extension MainPresenter: MainPresenterOutput {
    func viewDidLoad() {
        getAllBreeds()
    }
    
    func showSubBreeds(_ breed: (breed: String, subBreeds: [String])) {
        coordinator?.showSubBreeds(breed)
    }
    
    func showDogs(for breed: String) {
        coordinator?.showDogs(breed: (breed, nil))
    }
    
    func refreshTableView() {
        getAllBreeds()
    }
}
