//
//  ViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/05.
//

import UIKit
import RxCocoa
import RxSwift

class PhoneNumberViewModel: CommonMethods {    
    var baseView = BaseView()

    var phoneNumberEvent = PublishRelay<String>()
    var phoneNumber: String = ""
    
    func phoneNumberValidation(number: String) {
        phoneNumber = number
        phoneNumberEvent.accept(phoneNumber)
        print(phoneNumber)
        print(number)
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
        let baseViewToChange = BaseView()
        baseViewToChange.label.text = SignUpMessages.birth.messages
        let birth = BirthCustomView()
        baseViewToChange.view = birth
        
        let vc = SLPViewController(mainView: baseViewToChange)
        viewController.navigationController?.pushViewController(vc, animated: true)
        
//        let birthDatePicker = BirthCustomView().birthDatePicker
//        let birthTextField = BirthCustomView().birthDayTextField
        
//        let baseViewToChange = BaseView()
//        baseViewToChange.label.text = SignUpMessages.certification.messages
//        baseViewToChange.view = CustomTextField().certificationTextField
    }
}
