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
    let array = [0, 1, 2, 3]
    
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
                    self.mainView.button.isEnabled = false
                }
            }
            .disposed(by: disposeBag)
        
        //인증코드 담은 이벤트를 전달하면 화면전환
        viewModel.verificationCodePublisher
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { verificationCode in
                if self.viewModel.isValidPhoneNumber {
                    self.pushScene()
                } else {
                    self.view.makeToast(SignUpToastMessages.phoneNumber.messages, duration: 1, position: .top)
                }
            }, onError: { error in
                
            })
            .disposed(by: disposeBag)
    }
    
    func activateAction() {
        mainView.phoneNumberTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
        mainView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func textFieldEditing() {
        guard let text = mainView.phoneNumberTextField.text else { return }
        viewModel.phoneNumberValidation(number: text)
        print("text", text)
    }
    
    func pushScene() {
        let baseViewToChange = CertificationView()
        let vc = CertificationViewController(mainView: baseViewToChange)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func buttonTapped() {
        let number = viewModel.phoneNumber
        viewModel.requestVerificationCode(phoneNumber: number)
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

//extension PhoneNumberViewController: UITextFieldDelegate {
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else { return false }
//        let newString = (text as NSString).replacingCharacters(in: range, with: string)
//
//        if text.count <= 11 { //텍스트 입력할 때 formatter실행되면서 dash가 추가될때마다 text.count가 같이 증가하기 때문에 11을 기준으로 분기
//            textField.text = viewModel.formatter(newString, form: "XXX-XXX-XXXX")
//        } else {
//            textField.text = viewModel.formatter(newString, form: "XXX-XXXX-XXXX")
//        }
//
//        viewModel.phoneNumberValidation(number: text)
//
//        guard let text = textField.text, let textRange = Range(range, in: text) else {
//            return false
//        }
//        let updatedText = text.replacingCharacters(in: textRange, with: string)
//        print("range", range)
//        print("textRange", textRange)
//        print("text", text)
//        print("updatedText", updatedText)
//        return false
//    }
//}
