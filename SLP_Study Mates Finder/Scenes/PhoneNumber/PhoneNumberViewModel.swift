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
    var signUpData: SignUpData = SignUpData()
    
    var disposeBag = DisposeBag()
    
    func phoneNumberValidation(number: String) {
        let regularExpression = "^01([0-9])-?([0-9]{4})-?([0-9]{4})$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        let isValid = predicate.evaluate(with: number)
        isValidPhoneNumber = isValid
        phoneNumberEvent.accept(isValidPhoneNumber)
        signUpData.phoneNumber = number.replacingOccurrences(of: "-", with: "")
    }
    
    func requestVerificationCode() {
        FirebaseRequest.requestVerificationCode(phoneNumber: "+82 \(signUpData.phoneNumber)")
            .subscribe(onNext: { verificationID in
                self.signUpData.authVerificationID = verificationID
                self.verificationCodePublisher.accept(verificationID)
            }, onError: { error in
            })
            .disposed(by: disposeBag)
    }
}
