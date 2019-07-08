//
//  StatementItemDetailViewController.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import RxSwift
import RxCocoa

final class StatementItemDetailViewController: BaseViewController, StoryboardInitializable {

    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    
    var viewModel: StatementItemDetailViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        createViewModelBinding()
    }
    
    func setupUI() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = viewModel.statementItem.description
    }

    func createViewModelBinding() {

        cancelButton.rx.tap.subscribe(onNext: { [unowned self] (_ : Void) in
                    self.viewModel.coordinator.closeController()
                }).disposed(by: disposeBag)
    }

    deinit {
        debugPrint("[\(String(describing: type(of: self)))] - deinit -")
    }
}
