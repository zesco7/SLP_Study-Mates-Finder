//
//  PhoneNumberCheckViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit
import Alamofire
import Firebase
import FirebaseAuth
import RxCocoa
import RxSwift
import Toast

class PhoneNumberCheckViewController: BaseViewController {
    var mainView = PhoneNumberCheckView()
    let border = CALayer()
    let viewModel = PhoneNumberCheckViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.phoneNumberTextField.delegate = self
        phoneNumberAddTargetCollection()
        receiveTextButtonColorChange()
        print(UserDefaults.standard.string(forKey: "serverToken"))
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
    
    func requestVerificationCode(phoneNumber: String) {
        Auth.auth().languageCode = "kr";
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error)
                    return
                }
                print("verify phone")
                print(verificationID!)
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            }
    }
    
    func certificationCodeCheck() {
        //????????? ???????????????????????? ????????????(post)
        //???????????? ???????????? ?????????????????????(get)
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
            self.view.makeToast("?????? ?????? ?????? ??????", duration: 1, position: .top)
            let phoneNumberWithNoHyphen = mainView.phoneNumberTextField.text?.replacingOccurrences(of: "-", with: "")
            requestVerificationCode(phoneNumber: "+82 \(String(describing: phoneNumberWithNoHyphen!))")
            
            let phoneNumberIndex = phoneNumberWithNoHyphen?.index(phoneNumberWithNoHyphen!.startIndex, offsetBy: 1)
            let phoneNumberString = String(phoneNumberWithNoHyphen![phoneNumberIndex!...])
            print(phoneNumberString)
            UserDefaults.standard.set("+82\(phoneNumberWithNoHyphen)", forKey: "phoneNumberWithNoHyphen")
            certificationCodeCheck()
            //+@. ???????????? ??? ???????????? ??? 1~2??? ????????? ????????????
            let vc = CertificationNumberCheckViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.view.makeToast("????????? ???????????? ???????????????.", duration: 1, position: .top)
        }
    }
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.phoneNumberTextField.frame.size.height-1, width: mainView.phoneNumberTextField.frame.width, height: 1)
        border.gray3()
        mainView.phoneNumberTextField.layer.addSublayer((border))
    }
}

extension PhoneNumberCheckViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = mainView.phoneNumberTextField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        if text.count <= 11 { //Q. ??? 10??? ????????? 11???????
            mainView.phoneNumberTextField.text = phoneNumberFormatter(mask: "XXX-XXX-XXXX", phoneNumber: newString)
        } else {
            mainView.phoneNumberTextField.text = phoneNumberFormatter(mask: "XXX-XXXX-XXXX", phoneNumber: newString)
        }
        return false
    }
    
    func phoneNumberFormatter(mask: String, phoneNumber: String) -> String {
        let number = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result: String = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
}
