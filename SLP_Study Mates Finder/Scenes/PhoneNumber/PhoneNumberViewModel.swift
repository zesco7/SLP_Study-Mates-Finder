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

class PhoneNumberViewModel {
    var baseView = BaseView()
    
    var phoneNumberEvent = PublishRelay<Bool>()
    var verificationCodePublisher = PublishRelay<String>()
    var isValidPhoneNumber: Bool = false
    var phoneNumber: String = ""
    
    var disposeBag = DisposeBag()
    
    func phoneNumberValidation(number: String) {
        let regularExpression = "^01([0-9])-?([0-9]{4})-?([0-9]{4})$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        let isValid = predicate.evaluate(with: number)
        phoneNumber = number
        isValidPhoneNumber = isValid
        phoneNumberEvent.accept(isValidPhoneNumber)
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
    
    func requestVerificationCode(phoneNumber: String) {
        var number = phoneNumber
        number = number.replacingOccurrences(of: "-", with: "")
        FirebaseRequest.requestVerificationCode(phoneNumber: "+82 \(number)")
            .subscribe(onNext: { verificationID in
                UserDefaults.standard.set("+82\(number)", forKey: SignUpUserDefaults.phoneNumber.rawValue)
                print("폰번", SignUpUserDefaults.phoneNumber.userDefaults)
                self.verificationCodePublisher.accept(verificationID)
            }, onError: { error in
            })
            .disposed(by: disposeBag)
    }
}
