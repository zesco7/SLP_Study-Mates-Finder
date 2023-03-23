//
//  PhoneNumberViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/11.
//

import UIKit
import RxCocoa
import RxSwift
import JGProgressHUD

class PhoneNumberViewController: UIViewController {
    var mainView: PhoneNumberView
    let viewModel = PhoneNumberViewModel()
    let disposeBag = DisposeBag()
    let hud = JGProgressHUD()
    
    init(mainView: PhoneNumberView) {
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
        mainView.phoneNumberTextField.delegate = self
        mainView.phoneNumberTextField.keyboardType = .decimalPad
    }
    
    func bind() {
        viewModel.phoneNumberEvent.asDriver(onErrorJustReturn: false)
            .drive(with: mainView.button) { button, data in
                if data {
                    self.mainView.button.green()
                    self.mainView.button.isEnabled = true
                } else {
                    self.mainView.button.gray6()
                    self.mainView.button.isEnabled = false
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.verificationCodePublisher
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { verificationCode in
                self.hud.dismiss()
                self.pushScene()
            }, onError: { error in
                print("verificationCodePublisher 에러", error)
            })
            .disposed(by: disposeBag)
    }
    
    func showProgress() {
        hud.style = .dark
        hud.textLabel.text = "인증 요청 중"
        hud.show(in: self.view)
    }
    
    func activateAction() {
        mainView.phoneNumberTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
        mainView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func textFieldEditing() {
        guard let text = mainView.phoneNumberTextField.text else { return }
        viewModel.phoneNumberValidation(number: text)
    }
    
    func pushScene() {
        let baseViewToChange = CertificationView()
        let vc = CertificationViewController(mainView: baseViewToChange, signUpData: viewModel.signUpData)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func buttonTapped() {
        showProgress()
        viewModel.requestVerificationCode()
    }
}


extension PhoneNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        if range.location == 13 { return false }
        if range.length == 0 {
            if range.location == 3 || range.location == 8 {
                textField.text = "\(text)-\(string)"
                return false
            }
        }
        return true
    }
}
