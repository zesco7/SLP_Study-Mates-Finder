//
//  NicknameViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift

class NicknameViewModel: CommonProperties {
    var baseView = BaseView()
    var mainView = NicknameView()

    var nicknameEvent = PublishRelay<Bool>()
    var isValidNickname: Bool = false
    var signUpData = SignUpData(authVerificationID: "", certification: "", phoneNumber: "", nickName: "", birth: "", email: "", gender: 2)
    
    func nicknameValidation(_ nickname: String) {
        let regularExpression = "[가-힣a-zA-Z0-9]{2,10}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        let isValid = predicate.evaluate(with: nickname)
        isValidNickname = isValid
        nicknameEvent.accept(isValidNickname)
        signUpData.nickName = nickname
    }
}
