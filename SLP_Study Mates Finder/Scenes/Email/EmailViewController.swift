//
//  EmailViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

class EmailViewController: UIViewController {
    var mainView: EmailView
    let viewModel = EmailViewModel()
    let disposeBag = DisposeBag()
    
    init(mainView: EmailView, signUpData: SignUpData) {
        self.mainView = mainView
        self.viewModel.signUpData = signUpData
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
        
        activateAction()
        bind()
    }
    
    override func viewDidLayoutSubviews() { mainView.textFieldBorderAttribute() }
    
    func textFieldAttribute() {
        mainView.emailTextField.delegate = self
    }
    
    func bind() {
        viewModel.emailEvent.asDriver(onErrorJustReturn: false)
            .drive(with: mainView.emailButton) { button, data in
                if data {
                    self.mainView.emailButton.green()
                    self.mainView.emailButton.isEnabled = true
                } else {
                    self.mainView.emailButton.gray6()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func activateAction() {
        mainView.emailTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
        mainView.emailButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func textFieldEditing() {
        guard let text = mainView.emailTextField.text else { return }
        viewModel.emailValidation(text)
    }
    
    @objc func buttonTapped() {
        if viewModel.isValidEmail {
            pushScene()
        } else {
            self.view.makeToast(SignUpToastMessages.email.messages, duration: 1.0, position: .top)
        }
    }
    
    func pushScene() {
        let baseViewToChange = GenderView()
        let vc = GenderViewController(mainView: baseViewToChange, signUpData: viewModel.signUpData)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension EmailViewController: UITextFieldDelegate { }
