//
//  PhoneNumberCheckViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/11.
//

import Foundation
import RxSwift

class PhoneNumberCheckViewModel {
    
   var phoneNumber = PublishSubject<String>()
    
    func isValidPhoneNumber(phone: String?) -> Bool {
            guard phone != nil else { return false }

            let phoneRegEx = "[0-9]{11}"
            let pred = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
            return pred.evaluate(with: phone)
        }
    
    func checkValidation(text: String) {
//        phoneNumber.onNext(text)
//        print(text)
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .none
//        let convertedNumber =
    }
    
}
