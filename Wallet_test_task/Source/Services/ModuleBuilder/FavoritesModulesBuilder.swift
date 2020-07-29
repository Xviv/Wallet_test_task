//
//  FavoritesModulesBuilder.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

extension ModuleBuilder {
    static func createFavoriteBreedsModule(with coordinator: FavoritesCoordinator?) -> UIViewController {
        let controller = FavoriteBreedsController()
        let presenter = FavoriteBreedsPresenter(view: controller)
        
        presenter.coordinator = coordinator
        controller.presenter = presenter
        
        return controller
    }
    
    static func createFavoritesSubBreedsModule(with coordinator: FavoritesCoordinator?, breed: String) -> UIViewController {
        let controller = FavoritesSubBreedsController()
        let presenter = FavoritesSubBreedsPresenter(view: controller, breed: breed)

        presenter.coordinator = coordinator
        controller.presenter = presenter
        
        return controller
    }
    
    static func createFavoritesDogsModule(with coordinator: FavoritesCoordinator?, breed: String?, subBreed: String?) -> UIViewController {
        let controller = FavoritesDogsController()
        let presenter = FavoritesDogsPresenter(view: controller, breed: breed, subBreed: subBreed)
        
        presenter.coordinator = coordinator
        controller.presenter = presenter
        
        return controller
    }
}
