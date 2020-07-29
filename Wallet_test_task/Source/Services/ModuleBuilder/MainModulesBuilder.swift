//
//  MainModulesBuilder.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

extension ModuleBuilder {
    static func createMainModule(with coordinator: MainCoordinator?) -> UIViewController {
        let controller = MainViewController()
        let presenter = MainPresenter(view: controller)
        
        controller.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        presenter.coordinator = coordinator
        controller.presenter = presenter
        
        return controller
    }
    
    static func createSubBreedsModule(with coordinator: MainCoordinator?, breed: (breed: String, subBreeds: [String])) -> UIViewController {
        let controller = SubBreedsViewController()
        let presenter = SubBreedsPresenter(view: controller)

        presenter.coordinator = coordinator
        presenter.breed = breed
        controller.presenter = presenter
        
        return controller
    }
    
    static func createDogsModule(with coordinator: MainCoordinator?, breed: (breed: String, subBreed: String?)) -> UIViewController {
        let controller = DogsViewController()
        let presenter = DogsPresenter(view: controller)
        
        presenter.breed = breed
        controller.presenter = presenter
        
        return controller
    }
}
