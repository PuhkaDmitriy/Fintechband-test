//
//  ApiService.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/6/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa

enum ApiServiceFailureReason: Int, Error {
    case unAuthorized = 401,
         forbidden = 403,
         notFound = 404
}

extension ApiServiceFailureReason {
    func getErrorMessage() -> String? {
        switch self {
        case .unAuthorized:
            return "Please login to update friends friends."
        case .notFound:
            return "Failed to update friend. Please try again."
        case .forbidden:
            return "Access forbidden"
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

    private func makeRequest(withToken: String = Session.sharedInstance.token,
                             andPath: String) -> DataRequest {
        let headers: HTTPHeaders = [API.xToken : withToken]
        return  Alamofire.request(String(format: "%@%@", API.endpoint, andPath), headers: headers)
    }

}

