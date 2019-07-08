//
//  StatementItem+Extra.swift
//  Fintechband test
//
//  Created by Дмитрий Пучка on 7/8/19.
//  Copyright © 2019 Дмитрий Пучка. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

extension StatementItem {
    
    struct TitleValue {
        
        let title: String
        let value: String
        
        init(title: String, value: String) {
            self.title = title
            self.value = value
        }
    }
    
    func keyValueList() -> [TitleValue] {
        
        let currencyName = Currencyes(rawValue: currencyCode)?.description() ?? "unknown"
        
       let items = [TitleValue(title: NSLocalizedString("statementDetail.id", comment: ""), value: id),
                                              TitleValue(title: NSLocalizedString("statementDetail.time", comment: ""), value: time.unixTimeToString()),
                                              TitleValue(title: NSLocalizedString("statementDetail.description", comment: ""), value: description),
                                              TitleValue(title: NSLocalizedString("statementDetail.amount", comment: ""), value: amount.amountFormatToString()),
                                              TitleValue(title: NSLocalizedString("statementDetail.operationAmount", comment: ""), value: operationAmount.amountFormatToString()),
                                              TitleValue(title: NSLocalizedString("statementDetail.currency", comment: ""), value: currencyName),
                                              TitleValue(title: NSLocalizedString("statementDetail.commissionRate", comment: ""), value: commissionRate.amountFormatToString()),
                                              TitleValue(title: NSLocalizedString("statementDetail.cashbackAmount", comment: ""), value: cashbackAmount.amountFormatToString()),
                                              TitleValue(title: NSLocalizedString("statementDetail.balance", comment: ""), value: NSLocalizedString(hold ? "hold.true" : "hold.false", comment: ""))]
        
        return items
    }
}
