//
//  ApiService.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/6/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

enum ApiServiceFailureReason: Int, Error {
    case forbidden = 403,
         toManyRequests = 429,
         notFound = 404
}

extension ApiServiceFailureReason {
    func getErrorMessage() -> String? {
        switch self {
        case .forbidden:
            return NSLocalizedString("error.accessForbidden", comment: "")
        case .toManyRequests:
            return NSLocalizedString("error.toManyRequests", comment: "")
        case .notFound:
            return NSLocalizedString("error.notFound", comment: "")

        }
    }
}

class ApiService {

    // MARK: - get client

    func getClient(byToken token: String) -> Observable<Client> {
        return Observable.create { observer -> Disposable in
            self.makeRequest(withToken: token, andPath: API.clientInfo)
                    .validate()
                    .responseJSON { response in
                        switch response.result {
                        case .success:
                            guard let data = response.data else {
                                observer.onError(response.error ?? ApiServiceFailureReason.notFound)
                                return
                            }
                            do {
                                let client = try JSONDecoder().decode(Client.self, from: data)
                                observer.onNext(client)
                            } catch {
                                observer.onError(error)
                            }
                        case .failure(let error):
                            if let statusCode = response.response?.statusCode,
                               let reason = ApiServiceFailureReason(rawValue: statusCode)
                            {
                                observer.onError(reason)
                            }
                            observer.onError(error)
                        }
                    }
            return Disposables.create()
        }
    }

    // MARK: - get
    //GET /personal/statement/{account}/{from}/{to}


    func getStatement() -> Observable<[StatementItem]> {
        return Observable.create { observer -> Disposable in
            self.makeRequest(andPath: String(format:API.statements, "0", "1560556800", ""))
                    .validate()
                    .responseJSON { response in
                        switch response.result {
                        case .success:
                            guard let data = response.data else {
                                observer.onError(response.error ?? ApiServiceFailureReason.notFound)
                                return
                            }
                            do {
                                let statement = try JSONDecoder().decode([StatementItem].self, from: data)
                                observer.onNext(statement)
                            } catch {
                                observer.onError(error)
                            }
                        case .failure(let error):
                            if let statusCode = response.response?.statusCode,
                               let reason = ApiServiceFailureReason(rawValue: statusCode)
                            {
                                observer.onError(reason)
                            }
                            observer.onError(error)
                        }
                    }
            return Disposables.create()
        }
    }

}

extension ApiService {

    private func makeRequest(withToken: String = Session.sharedInstance.token ?? "",
                             andPath: String) -> DataRequest {
        let headers: HTTPHeaders = [API.xToken : withToken]
        return  Alamofire.request(String(format: "%@%@", API.endpoint, andPath), headers: headers)
    }

}

