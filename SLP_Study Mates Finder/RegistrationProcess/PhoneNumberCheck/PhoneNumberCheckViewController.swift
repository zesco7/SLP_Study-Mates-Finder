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
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingDidBegin), for: .editingDidBegin)
        mainView.phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextFieldEditingDidEnd), for: .editingDidEnd)
        mainView.receiveTextButton.addTarget(self, action: #selector(receiveTextButtonClicked), for: .touchUpInside)
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
        let vc = CertificationNumberCheckViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.phoneNumberTextField.frame.size.height-1, width: mainView.phoneNumberTextField.frame.width, height: 1)
        border.gray3()
        mainView.phoneNumberTextField.layer.addSublayer((border))
    }
    
    
    
}
