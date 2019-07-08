//
//  StatementViewModel.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//


struct StatementCellViewModel {
    let statementItem: StatementItem
    let name: String
    let amount: String
}

extension StatementCellViewModel {
    init(statementItem: StatementItem) {
        self.statementItem = statementItem
        self.name = statementItem.description
        self.amount = statementItem.amount.amountFormatToString()
    }
}
