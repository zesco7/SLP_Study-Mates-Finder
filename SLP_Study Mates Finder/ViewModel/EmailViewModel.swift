//
//  EmailViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift

class EmailViewModel: CommonMethods {
    var baseView = BaseView()
    var mainView = EmailView()

    var emailEvent = PublishRelay<Bool>()
    var isValidEmail: Bool = false
    var emailData: String?
    
    func emailValidation(_ email: String){
        let regularExpression = "^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,20}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        let isValid = predicate.evaluate(with: email)
        emailData = email
        isValidEmail = isValid
        emailEvent.accept(isValidEmail)
    }
       
    func buttonTapped(_ viewController: UIViewController){
        if isValidEmail {
            UserDefaults.standard.set(emailData, forKey: SignUpUserDefaults.email.rawValue)
            let baseViewToChange = GenderView()
            let vc = GenderViewController(mainView: baseViewToChange)
            viewController.navigationController?.pushViewController(vc, animated: true)
        } else {
            viewController.view.makeToast(SignUpToastMessages.email.messages, duration: 1.0, position: .top)
        }
    }
}
