//
//  AppDelegate.swift
//  iOS-CalculatorLC
//
//  Created by u633168 on 25/01/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup
        
        setupView()
        return true
    }
    
    // Setup View
    private func setupView() {
        window = UIWindow()
        let vc = HomeViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }

}

