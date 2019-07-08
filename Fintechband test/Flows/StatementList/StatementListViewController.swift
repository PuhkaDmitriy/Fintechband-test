//
//  StatementListViewController.swift
//  RepoSearcher
//
//  Created by Дмитрий Пучка on 7/7/19.
//  Copyright © 2019 UPTech Team. All rights reserved.
//

import UIKit
import PKHUD
import RxSwift
import RxDataSources

final class StatementListViewController: BaseViewController, StoryboardInitializable {

    // MARK: - outlets

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var balanceValueLabel: UILabel!
    @IBOutlet weak var creditLimitLabel: UILabel!
    @IBOutlet weak var creditLimitValueLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    // MARK - properties

    private let logoutButton = UIButton()
    var viewModel: StatementListViewModel!
    private let disposeBag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupUI()
        bindViewModel()
        setupCellTapHandling()
        viewModel.getStatement()
    }

    func setupUI() {

        balanceLabel.text = NSLocalizedString("title.balance", comment: "")
        creditLimitLabel.text = NSLocalizedString("title.creditLimit", comment: "")

        if let client = Session.sharedInstance.client {
            let observable = Observable.just(client)
            let _ = observable.subscribe (onNext:{ [weak self] client in

                self?.usernameLabel.text = client.name

                if let balance = client.accounts.first?.balance {
                    self?.balanceValueLabel.text = balance.amountFormatToString()
                }

                if let creditLimit = client.accounts.first?.creditLimit {
                    self?.creditLimitValueLabel.text = creditLimit.amountFormatToString()
                }

                print(client)
            }).disposed(by: disposeBag)
        }

        // logout button
        logoutButton.setTitle(NSLocalizedString("button.logout", comment: ""), for: .normal)
        logoutButton.setTitleColor(.blue, for: .normal)
        logoutButton.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
    }

    func bindViewModel() {

        logoutButton.rx.tap.subscribe(onNext: { [unowned self] (_ : Void) in
            self.viewModel.coordinator.navigateToTokenInput()
        }).disposed(by: disposeBag)

        self.tableView.dataSource = nil
        self.tableView.delegate = nil

        viewModel.statementCells.bind(to: self.tableView.rx.items) { tableView, index, element in
            let indexPath = IndexPath(item: index, section: 0)
            switch element {
            case .normal(let viewModel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.statementCellIdentifier, for: indexPath) as? StatementTableViewCell else {
                    return UITableViewCell()
                }
                cell.viewModel = viewModel
                return cell
            case .error(let message):
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = message
                return cell
            case .empty:
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = NSLocalizedString("title.noDataAvailable", comment: "")
                return cell
            }
        }.disposed(by: disposeBag)

        viewModel
                .onShowError
                .map { [weak self] in self?.presentSingleButtonDialog(alert: $0)}
                .subscribe()
                .disposed(by: disposeBag)

        viewModel
                .onShowLoadingHud
                .map { [weak self] in self?.setLoadingHud(visible: $0) }
                .subscribe()
                .disposed(by: disposeBag)
    }

    private func setupCellTapHandling() {
        tableView
                .rx
                .modelSelected(StatementTableViewCellType.self)
                .subscribe(onNext: { [weak self] statementCellType in
                    if case let .normal(viewModel) = statementCellType {
                        self?.viewModel.coordinator.navigateToDetails(viewModel.statementItem)
                    }
                    if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow {
                        self?.tableView?.deselectRow(at: selectedRowIndexPath, animated: true)
                    }
                }
                )
                .disposed(by: disposeBag)
    }

    deinit {
        debugPrint("[\(String(describing: type(of: self)))] - deinit -")
    }
}

// MARK: - SingleButtonDialogPresenter
extension StatementListViewController: SingleButtonDialogPresenter { }
