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

     // MARK: - outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK - properties

    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)

    var viewModel: StatementItemDetailViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        createViewModelBinding()
    
        viewModel.initDetails()
    }
    
    func setupUI() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = viewModel.statementItem.description
    }

    func createViewModelBinding() {
        cancelButton.rx.tap.subscribe(onNext: { [unowned self] (_ : Void) in
                    self.viewModel.coordinator.closeController()
                }).disposed(by: disposeBag)


        self.tableView.dataSource = nil
        self.tableView.delegate = nil

        viewModel.detailItems.bind(to: tableView.rx.items(cellIdentifier: CellIdentifiers.statementDetailTableViewCell)) { row, model, cell in
            (cell as? StatementDetailTableViewCell)?.viewModel = model
            }.disposed(by: disposeBag)
    }

    deinit {
        debugPrint("[\(String(describing: type(of: self)))] - deinit -")
    }
}
