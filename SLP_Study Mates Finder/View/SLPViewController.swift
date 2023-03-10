//
//  SLPViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/09.
//

import UIKit
import RxCocoa
import RxSwift

class SLPViewController: UIViewController {
    var mainView: BaseView
    let viewModel = PhoneNumberViewModel()
    let disposeBag = DisposeBag()

    init(mainView: BaseView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil) //nscoder는 스토리보드용
    }

    override func loadView() {
        self.view = mainView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.view.delegate = self
        bind()
        activateAction()
    }
    
    override func viewDidLayoutSubviews() { mainView.textFieldBorderAttribute() }
    
    func bind() {
        viewModel.phoneNumberEvent.asDriver(onErrorJustReturn: "")
            .map({ $0.count >= 10})
            .drive(with: mainView.button) { button, data in
                if data {
                    self.mainView.button.green()
                    self.mainView.button.isEnabled = true
                    print(data)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func activateAction() {
        mainView.view.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)

        mainView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func textFieldEditing() {
        //addTarget실행 안되는 이유?
        guard let text = mainView.view.text else { return }
        viewModel.phoneNumberValidation(number: text)
    }
    
    @objc func buttonTapped() { //다음 화면에 띄울 뷰 초기화, 화면 전환
        viewModel.buttonTapped(self)
        viewModel.phoneNumberValidation(number: "111111111111")
    }
}

extension SLPViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //텍스트 붙여넣기 했을때를 위해 range 파라미터 사용
        //텍스트필드 숫자유효성 검사 추가(붙여넣기 했을때 숫자가 아닐 수 있기 때문) ux측면에서 애초에 숫자만 보내는 것임.
        guard let text = mainView.view.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        if text.count <= 11 { //Q. 왜 10이 아니라 11부터?
            mainView.view.text = viewModel.formatter(newString, form: "XXX-XXX-XXXX") 
        } else {
            mainView.view.text = viewModel.formatter(newString, form: "XXX-XXXX-XXXX")
        }
        return false
    }
}
