//
//  StatementItemDetailViewModel.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import RxSwift
import RxCocoa

class StatementItemDetailViewModel {

    // MARK: - Inputs
    
    let statementItem: StatementItem
    var coordinator: StatementItemDetailCoordinator
    
    let detailItems: BehaviorRelay<[StatementItem.TitleValue]> = BehaviorRelay(value: [])
    
    init(coordinator: StatementItemDetailCoordinator, statementItem: StatementItem) {
        self.coordinator = coordinator
        self.statementItem = statementItem
    }
    
    func initDetails() {
        self.detailItems.accept(statementItem.keyValueList())
    }

}
