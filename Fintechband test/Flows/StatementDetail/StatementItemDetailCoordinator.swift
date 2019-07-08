//
//  StatementItemDetailCoordinator.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import UIKit
import RxSwift

class StatementItemDetailCoordinator {

    let statementItem: StatementItem
    var rootViewController: UIViewController!

    init(statementItem: StatementItem) {
        self.statementItem = statementItem
    }

    func createFlow() -> UIViewController {
        let vc = StatementItemDetailViewController.initFromStoryboard(name: Storyboards.statementDetail)
        let viewModel = StatementItemDetailViewModel(coordinator: self, statementItem: statementItem)
        vc.viewModel = viewModel
        rootViewController = UINavigationController(rootViewController: vc)
        return rootViewController
    }

    func closeController() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
