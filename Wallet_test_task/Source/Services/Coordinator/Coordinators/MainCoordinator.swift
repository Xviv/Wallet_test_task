//
//  MainCoordinator.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let module = ModuleBuilder.createMainModule(with: self)
        navigationController.pushViewController(module, animated: false)
    }
    
    func showSubBreeds(_ breed: (breed: String, subBreeds: [String])) {
        let module = ModuleBuilder.createSubBreedsModule(with: self, breed: breed)
        navigationController.pushViewController(module, animated: true)
    }
    
    func showDogs(breed: (breed: String, subBreed: String?)) {
        let module = ModuleBuilder.createDogsModule(with: self, breed: breed)
        navigationController.pushViewController(module, animated: true)
    }
}
