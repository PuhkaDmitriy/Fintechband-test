//
//  Session.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import Foundation

final class Session {
    
    static let sharedInstance = Session()

    var token: String?
    var client: Client?

    private init() {}

    func saveToken(_ token: String?, _ client: Client) {
        self.token = token
        self.client = client
    }

    func clear() {
        self.token = nil
        self.client = nil
    }
    
}
