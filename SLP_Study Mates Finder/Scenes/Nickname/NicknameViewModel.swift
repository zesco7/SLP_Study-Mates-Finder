//
//  NicknameViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift

class NicknameViewModel {
    var baseView = BaseView()
    var mainView = NicknameView()

    var nicknameEvent = PublishRelay<Bool>()
    var isValidNickname: Bool = false
    var nicknameData: String?
    
    func nicknameValidation(_ nickname: String) {
        let regularExpression = "[가-힣a-zA-Z0-9]{2,10}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        let isValid = predicate.evaluate(with: nickname)
        nicknameData = nickname
        isValidNickname = isValid
        nicknameEvent.accept(isValidNickname)
        UserDefaults.standard.set(nicknameData, forKey: SignUpUserDefaults.nickname.rawValue)
    }
}
