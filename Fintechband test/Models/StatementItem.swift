//
//  StatementItem.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import Foundation

struct StatementItem: Codable {
    let id: String
    let time: Double
    let description: String
    let mcc: Int
    let hold: Bool
    let amount: Double
    let operationAmount: Double
    let currencyCode: Int
    let commissionRate: Double
    let cashbackAmount: Double
    let balance: Double
}