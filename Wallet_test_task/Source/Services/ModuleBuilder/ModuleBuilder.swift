//
//  ModuleBuilder.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func createMainModule(with coordinator: MainCoordinator?) -> UIViewController
    static func createSubBreedsModule(with coordinator: MainCoordinator?, breed: (breed: String, subBreeds: [String])) -> UIViewController
    static func createDogsModule(with coordinator: MainCoordinator?, breed: (breed: String, subBreed: String?)) -> UIViewController
    
    
    static func createFavoriteBreedsModule(with coordinator: FavoritesCoordinator?) -> UIViewController
    static func createFavoritesSubBreedsModule(with coordinator: FavoritesCoordinator?, breed: String) -> UIViewController
    static func createFavoritesDogsModule(with coordinator: FavoritesCoordinator?, breed: String?, subBreed: String?) -> UIViewController
    
}

class ModuleBuilder: ModuleBuilderProtocol { }
