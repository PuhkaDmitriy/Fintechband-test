//
//  Currencyes.swift
//  Fintechband test
//
//  Created by Дмитрий Пучка on 7/8/19.
//  Copyright © 2019 Дмитрий Пучка. All rights reserved.
//

import Foundation

enum Currencies: Int {
    case UAH = 980,
         USD = 840,
         EUR = 978,
         GBP = 826
}

extension Currencies {
    
    func description() -> String {
        switch self {
        case .UAH:
            return "UAH"
        case .USD:
            return "USD"
        case .EUR:
            return "EUR"
        case .GBP:
            return "GBP"
        }
    }
}
