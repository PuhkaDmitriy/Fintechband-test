//
//  TokenInputViewModel.swift
//  Fintechband test
//
//  Created by Дмитрий Пучка on 7/8/19.
//  Copyright © 2019 Дмитрий Пучка. All rights reserved.
//

import RxSwift
import RxCocoa
import Foundation

class TokenInputViewModel {

    // MARK: - Inputs

    var disposeBag = DisposeBag()
    var apiService: ApiService
    var coordinator: TokenInputCoordinator

    private let loadInProgress = BehaviorRelay(value: false)
    let onShowError = PublishSubject<SingleButtonAlert>()

    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress
                .asObservable()
                .distinctUntilChanged()
    }

    init(coordinator: TokenInputCoordinator, apiService: ApiService = ApiService()) {
        self.coordinator = coordinator
        self.apiService = apiService
    }

}

extension TokenInputViewModel {

    func sendToken(token: String) {

        loadInProgress.accept(true)

        self.apiService.getClient(byToken: token)
                .subscribe(
                        onNext: { [weak self] client in
                            Session.sharedInstance.saveToken(token, client)
                            self?.loadInProgress.accept(false)
                            self?.coordinator.showStatementList()
                        },
                        onError: { [weak self] error in
                            self?.loadInProgress.accept(false)
                            let errorMessage = (error as? ApiServiceFailureReason)?.getErrorMessage() ?? "Could not connect to server. Check your network and try again later."
                            let okAlert = SingleButtonAlert(title: "Error",
                                    message: errorMessage,
                                    action: AlertAction(buttonTitle: NSLocalizedString("button.ok", comment: ""), handler: { print("Go pressed!") })
                            )
                            self?.onShowError.onNext(okAlert)
                        }
                )
                .disposed(by: disposeBag)
    }
}
