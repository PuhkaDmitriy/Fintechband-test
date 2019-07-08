//
//  User.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/6/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

struct Client: Codable {
    let name: String
    let accounts: [Account]
}

struct Account: Codable {
    let id: String
    let balance: Double
    let creditLimit: Double
    let currencyCode: Int
    let cashbackType: String
}
