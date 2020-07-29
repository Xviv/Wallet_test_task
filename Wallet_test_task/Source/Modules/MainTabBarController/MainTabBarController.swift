//
//  MainTabBarController.swift
//  Wallet_test_task
//
//  Created by Dan on 29.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    //MARK: - Properties
    let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
    let favoritesCoordinator = FavoritesCoordinator(navigationController: UINavigationController())
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCoordinator.start()
        favoritesCoordinator.start()
        
        viewControllers = [
            mainCoordinator.navigationController,
            favoritesCoordinator.navigationController
        ]
    }
}
