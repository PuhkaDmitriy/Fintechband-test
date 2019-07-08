//
//  AppDelegate.swift
//  Fintechband test
//
//  Created by Дмитрий Пучка on 7/8/19.
//  Copyright © 2019 Дмитрий Пучка. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupCoordinator()
        return true
    }

    private func setupCoordinator() {
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator.start()
    }
}

