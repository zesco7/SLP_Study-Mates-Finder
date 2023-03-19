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

class PhoneNumberViewModel: CommonProperties {
    var baseView = BaseView()
    
    var phoneNumberEvent = PublishRelay<Bool>()
    var verificationCodePublisher = PublishRelay<String>()
    var isValidPhoneNumber: Bool = false
    var signUpData = SignUpData(authVerificationID: "", certification: "", phoneNumber: "", nickName: "", birth: "", email: "", gender: 2)
    
    var disposeBag = DisposeBag()
    
    func phoneNumberValidation(number: String) {
        let regularExpression = "^01([0-9])-?([0-9]{4})-?([0-9]{4})$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        let isValid = predicate.evaluate(with: number)
        isValidPhoneNumber = isValid
        phoneNumberEvent.accept(isValidPhoneNumber)
        signUpData.phoneNumber = number.replacingOccurrences(of: "-", with: "")
        print("phoneNumber", signUpData.phoneNumber)
//        print("defaults", signUpData.signUpDataWithNothing)
    }
    
    func requestVerificationCode() {
        FirebaseRequest.requestVerificationCode(phoneNumber: "+82 \(signUpData.phoneNumber)")
            .subscribe(onNext: { verificationID in
                self.signUpData.authVerificationID = verificationID
                self.verificationCodePublisher.accept(verificationID)
                print("verificationCodePublisher", self.verificationCodePublisher)
            }, onError: { error in
            })
            .disposed(by: disposeBag)
    }
    
//    func formatter(_ input: String, form: String) -> String {
//        let number = input.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
//        var result: String = ""
//        var index = number.startIndex
//
//        for character in form where index < number.endIndex {
//            if character == "X" {
//                result.append(number[index])
//                index = number.index(after: index)
//            } else {
//                result.append(character)
//            }
//        }
//        return result
//    }
}
