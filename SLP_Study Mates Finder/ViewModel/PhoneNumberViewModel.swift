//
//  ViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/05.
//

import UIKit
import Alamofire
import Firebase
import FirebaseAuth
import RxCocoa
import RxSwift

class PhoneNumberViewModel: CommonMethods {    
    var baseView = BaseView()
    
    var phoneNumberEvent = PublishRelay<String>()
    var phoneNumber: String = ""
    
    func phoneNumberValidation(number: String) {
        phoneNumber = number
        phoneNumberEvent.accept(phoneNumber)
    }
    
    func formatter(_ input: String, form: String) -> String {
        let number = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result: String = ""
        var index = number.startIndex
        
        for character in form where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
    
    func buttonTapped(_ viewController: UIViewController){
        if phoneNumber.count >= 10 {
            let baseViewToChange = CertificationView()
            let vc = CertificationViewController(mainView: baseViewToChange)
            viewController.navigationController?.pushViewController(vc, animated: true)
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
        //서버에 인증번호일치확인 통신요청(post)
        //인증번호 일치하면 사용자정보확인(get)
    }
    
//    @objc func receiveTextButtonClicked() {
//        let phoneNumberValidation = phoneNumberValidation(number: mainView.phoneNumberTextField.text!)
//        if phoneNumberValidation == true {
//            self.view.makeToast("전화 번호 인증 시작", duration: 1, position: .top)
//            let phoneNumberWithNoHyphen = mainView.phoneNumberTextField.text?.replacingOccurrences(of: "-", with: "")
//            requestVerificationCode(phoneNumber: "+82 \(String(describing: phoneNumberWithNoHyphen!))")
//
//            let phoneNumberIndex = phoneNumberWithNoHyphen?.index(phoneNumberWithNoHyphen!.startIndex, offsetBy: 1)
//            let phoneNumberString = String(phoneNumberWithNoHyphen![phoneNumberIndex!...])
//            print(phoneNumberString)
//            UserDefaults.standard.set("+82\(phoneNumberWithNoHyphen)", forKey: "phoneNumberWithNoHyphen")
//            certificationCodeCheck()
//            //+@. 인증요청 후 통신요청 후 1~2초 있다가 화면전환
//            let vc = CertificationNumberCheckViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else {
//            self.view.makeToast(ToastMessages.phoneNumber.messages, duration: 1, position: .top)
//        }
//    }
}
