//
//  TokenInputCoordinator.swift
//  Fintechband test
//
//  Created by Дмитрий Пучка on 7/8/19.
//  Copyright © 2019 Дмитрий Пучка. All rights reserved.
//

import UIKit

class TokenInputCoordinator: Coordinator {

    // MARK: - Properties
    let window: UIWindow?
    var rootViewController: UINavigationController!
    
    // MARK: - Coordinator
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        
        let viewController = TokenInputViewController.initFromStoryboard(name: Storyboards.tokenInput)
        let viewModel = TokenInputViewModel(coordinator: self)
        viewController.viewModel = viewModel
        
        self.rootViewController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
        func showTransactions() {
            StatementListCoordinator(rootViewController: rootViewController).start()
        }
}
