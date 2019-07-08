//
//  StatementItemDetailCoordinator.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import UIKit
import RxSwift

class StatementItemDetailCoordinator: Coordinator {

    let statementItem: StatementItem
    var rootViewController: UINavigationController

    init(rootViewController: UINavigationController, statementItem: StatementItem) {
        self.rootViewController = rootViewController
        self.statementItem = statementItem
    }

    override func start() {
        let viewController = StatementItemDetailViewController.initFromStoryboard(name: Storyboards.statementDetail)
        let viewModel = StatementItemDetailViewModel(coordinator: self, statementItem: statementItem)
        viewController.viewModel = viewModel
    
        rootViewController.present(UINavigationController(rootViewController: viewController), animated: true, completion: nil)
    }

    func closeController() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
