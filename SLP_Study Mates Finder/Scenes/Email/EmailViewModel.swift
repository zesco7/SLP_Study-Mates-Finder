//
//  EmailViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift

class EmailViewModel: CommonProperties {
    var baseView = BaseView()
    
    var emailEvent = PublishRelay<Bool>()
    var isValidEmail: Bool = false
    var signUpData: SignUpData = SignUpData()
    
    func emailValidation(_ email: String){
        let regularExpression = "^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,20}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        let isValid = predicate.evaluate(with: email)
        isValidEmail = isValid
        emailEvent.accept(isValidEmail)
        signUpData.email = email
    }
}
