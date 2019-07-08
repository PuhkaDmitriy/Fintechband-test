//
//  StatementListViewModel.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import RxSwift
import RxCocoa

enum StatementTableViewCellType {
    case normal(cellViewModel: StatementCellViewModel)
    case error(message: String)
    case empty
}

class StatementListViewModel {

    var statementCells: Observable<[StatementTableViewCellType]> {
        return cells.asObservable()
    }
    var onShowLoadingHud: Observable<Bool> {
        return loadInProgress
                .asObservable()
                .distinctUntilChanged()
    }
    let onShowError = PublishSubject<SingleButtonAlert>()
    let apiService: ApiService
    let coordinator: StatementListCoordinator

    let disposeBag = DisposeBag()

    private let loadInProgress = BehaviorRelay(value: false)
    private let cells = BehaviorRelay<[StatementTableViewCellType]>(value: [])

    init(coordinator: StatementListCoordinator, apiService: ApiService = ApiService()) {
        self.coordinator = coordinator
        self.apiService = apiService
    }

    func getStatement() {

        loadInProgress.accept(true)

        apiService
                .getStatement()
                .subscribe(
                        onNext: { [weak self] statements in
                            self?.loadInProgress.accept(false)
                            guard statements.count > 0 else {
                                self?.cells.accept([.empty])
                                return
                            }

                            self?.cells.accept(statements.compactMap { .normal(cellViewModel: StatementCellViewModel(statementItem: $0 )) })
                        },
                        onError: { [weak self] error in
                            self?.loadInProgress.accept(false)
                            self?.cells.accept([
                                .error(
                                        message: (error as? ApiServiceFailureReason)?.getErrorMessage() ?? "Loading failed, check network connection"
                                )
                            ])
                        }
                ).disposed(by: disposeBag)
    }
}
