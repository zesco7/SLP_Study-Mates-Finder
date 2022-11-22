//
//  PhoneNumberCheckViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit

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
        

    }
    
    func phoneNumberAddTargetCollection() {
        mainView.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingDidBegin), for: .editingDidBegin)
        mainView.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingDidEnd), for: .editingDidEnd)
        mainView.receiveTextButton.addTarget(self, action: #selector(receiveTextButtonClicked), for: .touchUpInside)
    }
    
    func phoneNumberValidation(number: String) -> Bool {
        let regex = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: number)
        print(NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: number))
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
        phoneNumberValidation(number: mainView.phoneNumberTextField.text!)
        print(#function)
//        let vc = CertificationNumberCheckViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
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
