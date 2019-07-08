//
//  TokenInputCoordinator.swift
//  Fintechband test
//
//  Created by Дмитрий Пучка on 7/8/19.
//  Copyright © 2019 Дмитрий Пучка. All rights reserved.
//

import UIKit

class TokenInputCoordinator {

    // MARK: - Properties

    private unowned var rootViewController: UIViewController!
    
    func createFlow() -> UIViewController {
        let vc = TokenInputViewController.initFromStoryboard(name: Storyboards.tokenInput)
        let viewModel = TokenInputViewModel(coordinator: self)
        vc.viewModel = viewModel
        rootViewController = vc
        
        return rootViewController
    }
    
        func showStatementList() {
            let vc = StatementListCoordinator().createFlow()
            rootViewController.present(vc, animated: true, completion: nil)
        }
}
