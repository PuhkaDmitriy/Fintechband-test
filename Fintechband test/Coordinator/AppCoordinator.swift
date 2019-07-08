//
//  AppCoordinator.swift
//  Fintechband test
//
//  Created by Дмитрий Пучка on 7/8/19.
//  Copyright © 2019 Дмитрий Пучка. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    
    // MARK: - Properties
    private let window: UIWindow
    
    // MARK: - Coordinator
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tokenCoordinator = TokenInputCoordinator()
        let vc = tokenCoordinator.createFlow()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
