//
//  NicknameViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

class NicknameViewController: UIViewController {
    var mainView: NicknameView
    let viewModel = NicknameViewModel()
    let disposeBag = DisposeBag()
    
    init(mainView: NicknameView, signUpData: SignUpData) {
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
        mainView.nicknameTextField.delegate = self
    }
    
    func bind() {
        viewModel.nicknameEvent.asDriver(onErrorJustReturn: false)
            .drive(with: mainView.nicknameButton) { button, data in
                if data {
                    self.mainView.nicknameButton.green()
                    self.mainView.nicknameButton.isEnabled = true
                } else {
                    self.mainView.nicknameButton.gray6()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func activateAction() {
        mainView.nicknameTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
        mainView.nicknameButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func pushScene() {
        let baseViewToChange = BirthView()
        let vc = BirthViewController(mainView: baseViewToChange, signUpData: viewModel.signUpData)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textFieldEditing() {
        guard let text = mainView.nicknameTextField.text else { return }
        viewModel.nicknameValidation(text)
    }
    
    @objc func buttonTapped() {
        if viewModel.isValidNickname {
            pushScene()
        } else {
            self.view.makeToast(SignUpToastMessages.nickname.messages, duration: 1.0, position: .top)
        }
    }
}

extension NicknameViewController: UITextFieldDelegate { }
