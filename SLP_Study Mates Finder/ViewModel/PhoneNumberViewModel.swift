//
//  ViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/05.
//

import UIKit
import Firebase
import FirebaseAuth
import RxCocoa
import RxSwift

class PhoneNumberViewModel: CommonMethods {
    var baseView = BaseView()
    
    var phoneNumberEvent = PublishRelay<Bool>()
    var isValidPhoneNumber: Bool = false
    var phoneNumber: String = ""
    
    func phoneNumberValidation(number: String) {
        let regularExpression = "^01([0-9])([0-9]{3,4})([0-9]{4})$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        let isValid = predicate.evaluate(with: number)
        phoneNumber = number
        isValidPhoneNumber = isValid
        phoneNumberEvent.accept(isValidPhoneNumber)
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
        let baseViewToChange = CertificationView()
        let vc = CertificationViewController(mainView: baseViewToChange)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestVerificationCode(phoneNumber: String) {
        FirebaseRequest.requestVerificationCode(phoneNumber: phoneNumber)
    }
    
    func receiveFirebaseCode(_ viewController: UIViewController) {
        if isValidPhoneNumber {
            requestVerificationCode(phoneNumber: "+82 \(phoneNumber)")
            UserDefaults.standard.set("+82\(phoneNumber)", forKey: SignUpUserDefaults.phoneNumber.rawValue)
            buttonTapped(viewController) //+@. 인증요청 후 통신요청 후 1~2초 있다가 화면전환
        } else {
            viewController.view.makeToast(SignUpToastMessages.phoneNumber.messages, duration: 1, position: .top)
        }
    }
}
