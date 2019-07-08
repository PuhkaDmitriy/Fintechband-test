//
//  Constants.swift
//  Fintechband test
//
//  Created by Дмитрий Пучка on 7/8/19.
//  Copyright © 2019 Дмитрий Пучка. All rights reserved.
//

struct API {
    static let endpoint = "https://api.monobank.ua/"
    static let xToken = "X-Token"
    static let clientInfo = "personal/client-info"
    static let statements = "/personal/statement/%@/%@/%@" // {account id}/{from}/{to}
}

struct Storyboards {
    static let main = "Main"
    static let tokenInput = "TokenInput"
    static let statementDetail = "StatementDetail"
    static let statementList = "StatementList"
}

struct CellIdentifier {
    static let statementCellIdentifier = "StatementTableViewCell"
}

struct CellIdentifiers {
    static let statementDetailTableViewCell = "StatementDetailTableViewCell"
}
