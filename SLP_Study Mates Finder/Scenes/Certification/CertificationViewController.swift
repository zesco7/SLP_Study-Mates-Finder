//
//  CertificationViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/11.
//

import UIKit
import RxCocoa
import RxSwift

class CertificationViewController: UIViewController {
    var mainView: CertificationView
    let viewModel = CertificationViewModel()
    let disposeBag = DisposeBag()

    init(mainView: CertificationView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        self.view = mainView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldAttribute()
        bind()
        activateAction()
    }
    
    override func viewDidLayoutSubviews() { mainView.textFieldBorderAttribute() }
    
    func textFieldAttribute() {
        mainView.certificationTextField.delegate = self
    }
    
    func bind() {
        viewModel.certificationEvent.asDriver(onErrorJustReturn: false)
            .drive(with: mainView.certificationButton) { button, data in
                if data {
                    self.mainView.certificationButton.green()
                    self.mainView.certificationButton.isEnabled = true
                } else {
                    self.mainView.certificationButton.gray6()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func activateAction() {
        mainView.certificationTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
        mainView.retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        mainView.certificationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func textFieldEditing() {
        guard let text = mainView.certificationTextField.text else { return }
        viewModel.certificationValidation(code: text)
    }
    
    @objc func retryButtonTapped() { viewModel.retryButtonTapped() }
    
    @objc func buttonTapped() { viewModel.buttonTapped(self) }
}

extension CertificationViewController: UITextFieldDelegate { }
