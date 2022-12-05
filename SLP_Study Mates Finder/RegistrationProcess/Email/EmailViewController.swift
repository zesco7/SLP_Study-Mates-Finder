//
//  EmailViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit
import Toast

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
        mainView.emailTextField.rx.text
            .map { $0!.count > 1 && $0!.contains("@") && $0!.contains(".") }
            .withUnretained(self)
            .bind { (vc, value) in
                value ? self.mainView.emailPassButton.green() : self.mainView.emailPassButton.gray6()
            }
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
        if mainView.emailTextField.text!.count > 1 && mainView.emailTextField.text!.contains("@") && mainView.emailTextField.text!.contains(".") {
            UserDefaults.standard.set(mainView.emailTextField.text, forKey: "email")
            let vc = GenderViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.makeToast("이메일 형식이 올바르지 않습니다.", duration: 1.0, position: .top)
        }
    }
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.emailTextField.frame.size.height-1, width: mainView.emailTextField.frame.width, height: 1)
        border.gray3()
        mainView.emailTextField.layer.addSublayer((border))
    }
}
