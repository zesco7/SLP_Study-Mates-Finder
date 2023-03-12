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
        viewModel.phoneNumberEvent.asDriver(onErrorJustReturn: "")
            .map({ $0.count >= 10})
            .drive(with: mainView.button) { button, data in
                if data {
                    self.mainView.button.green()
                    self.mainView.button.isEnabled = true
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
        viewModel.buttonTapped(self)
    }
}

extension PhoneNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //새로운 텍스트가 들어올때는 replacementString으로 받아짐
        //텍스트필드는 업데이트 된적 없음(textField.text)
        //텍스트필드 값을 보여줄지 말지에 대한 메서드
        //텍스트 붙여넣기 했을때를 위해 range 파라미터 사용
        //텍스트필드 숫자유효성 검사 추가(붙여넣기 했을때 숫자가 아닐 수 있기 때문) ux측면에서 애초에 숫자만 보내는 것임.
        guard let text = mainView.phoneNumberTextField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        print("t", text)
        print("nt", newString)
        if text.count <= 11 { //Q. 왜 10이 아니라 11부터?
            textField.text = viewModel.formatter(newString, form: "XXX-XXX-XXXX")
        } else {
            textField.text = viewModel.formatter(newString, form: "XXX-XXXX-XXXX")
        }
        return true
    }
}
