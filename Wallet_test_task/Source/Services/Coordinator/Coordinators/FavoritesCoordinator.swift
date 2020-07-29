//
//  FavoritesCoordinator.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let module = ModuleBuilder.createFavoriteBreedsModule(with: self)
        module.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        navigationController.pushViewController(module, animated: true)
    }
    
    func showSubBreeds(breed: String) {
        let module = ModuleBuilder.createFavoritesSubBreedsModule(with: self, breed: breed)
        navigationController.pushViewController(module, animated: true)
    }
    
    func showDogs(breed: String?, subBreed: String?) {
        let module = ModuleBuilder.createFavoritesDogsModule(with: self, breed: breed, subBreed: subBreed)
        navigationController.pushViewController(module, animated: true)
    }
}
