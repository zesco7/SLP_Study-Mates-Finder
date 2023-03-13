//
//  PhoneNumberViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/11.
//

import UIKit
import RxCocoa
import RxSwift

class PhoneNumberViewController: UIViewController {
    var mainView: PhoneNumberView
    let viewModel = PhoneNumberViewModel()
    let disposeBag = DisposeBag()
    
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
    
    func textFieldAttribute() { mainView.phoneNumberTextField.delegate = self }
    
    func bind() {
        viewModel.phoneNumberEvent.asDriver(onErrorJustReturn: false)
            .drive(with: mainView.button) { button, data in
                if data {
                    self.mainView.button.green()
                    self.mainView.button.isEnabled = true
                } else {
                    self.mainView.button.gray6()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func activateAction() {
        mainView.phoneNumberTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
        mainView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func textFieldEditing() {
        guard let text = mainView.phoneNumberTextField.text else { return }
        viewModel.phoneNumberValidation(number: text)
    }
    
    @objc func buttonTapped() {
        viewModel.receiveFirebaseCode(self)
    }
}

extension PhoneNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        guard let text = mainView.phoneNumberTextField.text else { return false }
        //
        //        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        //        textField.text = viewModel.formatter(newString, form: "XXX-XXX-XXXX")
        //
        //        print("text", text)
        //        print("newString", newString)
        
        return true
    }
}
