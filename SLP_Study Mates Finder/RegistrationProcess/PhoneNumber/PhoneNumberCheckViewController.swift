//
//  PhoneNumberCheckViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit

import RxSwift
import Toast

class PhoneNumberCheckViewController: BaseViewController {
    var mainView = PhoneNumberCheckView()
    let border = CALayer()
    let viewModel = PhoneNumberCheckViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberAddTargetCollection()
        receiveTextButtonColorChange()
        
    }
    
    func phoneNumberAddTargetCollection() {
        mainView.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingDidBegin), for: .editingDidBegin)
        mainView.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingDidEnd), for: .editingDidEnd)
        mainView.receiveTextButton.addTarget(self, action: #selector(receiveTextButtonClicked), for: .touchUpInside)
    }
    
    func phoneNumberValidation(number: String) -> Bool {
        let regex = "^01([0-9])-?([0-9]{3,4})-?([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: number)
    }
    
    func receiveTextButtonColorChange() {
        mainView.phoneNumberTextField.rx.text
            .map { $0!.count >= 10}
            .withUnretained(self)
            .bind { (vc, value) in
                value ? self.mainView.receiveTextButton.green() : self.mainView.receiveTextButton.gray6()
            }
    }
 
    @objc func phoneNumberTextFieldEditingDidBegin() {
        border.black()
        mainView.phoneNumberTextField.layer.addSublayer((border))
    }
    
    @objc func phoneNumberTextFieldEditingDidEnd() {
        border.gray3()
        mainView.phoneNumberTextField.layer.addSublayer((border))
    }
    
    @objc func receiveTextButtonClicked() {
        let phoneNumberValidation = phoneNumberValidation(number: mainView.phoneNumberTextField.text!)
        if phoneNumberValidation == true {
            self.view.makeToast("전화 번호 인증 시작", duration: 1, position: .top)
            //통신요청 후 1~2초 있다가 화면전환
//            let vc = CertificationNumberCheckViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.makeToast("잘못된 전화번호 형식입니다.", duration: 1, position: .top)
        }
    }
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.phoneNumberTextField.frame.size.height-1, width: mainView.phoneNumberTextField.frame.width, height: 1)
        border.gray3()
        mainView.phoneNumberTextField.layer.addSublayer((border))
    }
}

extension String {
    public var withHypen: String {
        var stringWithHypen: String = self
        stringWithHypen.insert("-", at: stringWithHypen.index(stringWithHypen.startIndex, offsetBy: 3))
        stringWithHypen.insert("-", at: stringWithHypen.index(stringWithHypen.endIndex, offsetBy: -4))
        
        return stringWithHypen
    }
}
