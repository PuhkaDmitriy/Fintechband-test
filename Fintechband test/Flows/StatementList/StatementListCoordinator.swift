//
//  StatementListCoordinator.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import UIKit

class StatementListCoordinator: Coordinator {

    private let rootViewController: UINavigationController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    override func start() {
        let viewController = StatementListViewController.initFromStoryboard(name: Storyboards.statementList)
        viewController.viewModel = StatementListViewModel(coordinator: self)
       
        self.rootViewController.pushViewController(viewController, animated: true)
    }

    func navigateToDetails(_ statementItem: StatementItem) {
        StatementItemDetailCoordinator(rootViewController: rootViewController,
                statementItem: statementItem).start()
    }
}
