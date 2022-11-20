//
//  EmailViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit

class EmailViewController: BaseViewController {
    var mainView = EmailView()
    let border = CALayer()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        mainView.emailTextField.becomeFirstResponder()
        emailAddTargetCollection()
        emailValidation()
    }
    
    func emailAddTargetCollection() {
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldEditingDidBegin), for: .editingDidBegin)
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldEditingDidEnd), for: .editingDidEnd)
        mainView.emailPassButton.addTarget(self, action: #selector(emailPassButtonClicked), for: .touchUpInside)
    }
    
    func emailValidation() {
        
    }
    
    @objc func emailTextFieldEditingDidBegin() {
        border.black()
        mainView.emailTextField.layer.addSublayer((border))
    }
    
    @objc func emailTextFieldEditingDidEnd() {
        border.gray3()
        mainView.emailTextField.layer.addSublayer((border))
    }
    
    @objc func emailPassButtonClicked() {
        let vc = GenderViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.emailTextField.frame.size.height-1, width: mainView.emailTextField.frame.width, height: 1)
        border.gray3()
        mainView.emailTextField.layer.addSublayer((border))
    }
}
