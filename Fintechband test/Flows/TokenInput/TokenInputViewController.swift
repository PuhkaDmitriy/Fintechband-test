//
//  TokenInputViewController.swift
//  Fintechband test
//
//  Created by Дмитрий Пучка on 7/8/19.
//  Copyright © 2019 Дмитрий Пучка. All rights reserved.
//

import RxSwift
import RxCocoa

final class TokenInputViewController: BaseViewController, StoryboardInitializable {

    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

    var viewModel: TokenInputViewModel!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        createViewModelBinding()
    }

    func setupUI() {
        tokenTextField.placeholder = NSLocalizedString("placeholder.token", comment: "")
        sendButton.setTitle(NSLocalizedString("button.go", comment: ""), for: .normal)
        
        tokenTextField.text = "uP8PZfQdOADDUVhctCYFPjan3agdSiF08njYOcnrURyY" // TODO - удалить
    }
    
    func createViewModelBinding() {

        tokenTextField.rx.text.orEmpty
                .map {$0.count > 0}
                .share(replay: 1)// without this map would be executed once for each binding, rx is stateless by default
                .bind(to: sendButton.rx.isEnabled)
                .disposed(by: disposeBag)

        sendButton.rx.tap
                .subscribe(onNext: { [unowned self] (_ : Void) in
                    self.viewModel.sendToken(token: self.tokenTextField.text ?? "")
                })
                .disposed(by: disposeBag)

        self.viewModel
                .onShowError
                .map { [unowned self] in self.presentSingleButtonDialog(alert: $0)}
                .subscribe()
                .disposed(by: disposeBag)

        self.viewModel
                .onShowLoadingHud
                .map { [unowned self] in self.setLoadingHud(visible: $0) }
                .subscribe()
                .disposed(by: disposeBag)
    }
    
    deinit {
        debugPrint("[\(String(describing: type(of: self)))] - deinit -")
    }
}

// MARK: - SingleButtonDialogPresenter

extension TokenInputViewController: SingleButtonDialogPresenter {

}
