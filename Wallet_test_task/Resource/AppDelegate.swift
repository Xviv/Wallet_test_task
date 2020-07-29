//
//  AppDelegate.swift
//  Wallet_test_task
//
//  Created by Dan on 28.07.2020.
//  Copyright © 2020 Daniil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       window = UIWindow(frame: UIScreen.main.bounds)
       window?.rootViewController = MainTabBarController()
       window?.makeKeyAndVisible()
        
        return true
    }

}

