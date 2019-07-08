//
//  StatementListCoordinator.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import UIKit

class StatementListCoordinator {

    var rootViewController: UIViewController!

    func createFlow() -> UIViewController {
        let vc = StatementListViewController.initFromStoryboard(name: Storyboards.statementList)
        vc.viewModel = StatementListViewModel(coordinator: self)
        rootViewController = UINavigationController(rootViewController: vc)
        return rootViewController
    }

    func navigateToDetails(_ statementItem: StatementItem) {
        let vc = StatementItemDetailCoordinator(statementItem: statementItem).createFlow()
        rootViewController.present(vc, animated: true)
    }
}
