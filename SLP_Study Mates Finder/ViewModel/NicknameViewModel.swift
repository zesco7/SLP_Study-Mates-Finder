//
//  NicknameViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift

class NicknameViewModel: CommonMethods {
    var baseView = BaseView()
    var mainView = NicknameView()

    var nicknameEvent = PublishRelay<Bool>()
    var isNickname: Bool = false
    
    func nicknameValidation(_ nickname: String){
        if nickname.count >= 1 && nickname.count <= 10 {
            isNickname = true
            nicknameEvent.accept(isNickname)
            //특수문자 제한 조건 및 조건 충족 여부 토스트 필요
        } else {
            isNickname = false
            nicknameEvent.accept(isNickname)
        }
    }
   
    func buttonTapped(_ viewController: UIViewController){
        if isNickname {
            let baseViewToChange = BirthView()
            let vc = BirthViewController(mainView: baseViewToChange)
            viewController.navigationController?.pushViewController(vc, animated: true)
        } else {
            viewController.view.makeToast(ToastMessages.nickname.messages, duration: 1.0, position: .top)
        }
    }
}
