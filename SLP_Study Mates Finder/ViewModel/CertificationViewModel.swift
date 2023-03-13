//
//  CertificationViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift

class CertificationViewModel: CommonMethods {
    var baseView = BaseView()
    
//    var certificationCode: Observable<String>?
//    var isValid: Observable<Bool> = Observable(false)
//    
//    func checkValidation(code: String) {
//        if code.count >= 6 {
//            isValid.value = true
//        } else {
//            isValid.value = false
//        }
//    }
    
    func buttonTapped(_ viewController: UIViewController){
        let baseViewToChange = NicknameView()
        let vc = NicknameViewController(mainView: baseViewToChange)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func certificationCodeCheck() {
        //서버에 인증번호일치확인 통신요청(post)
        //인증번호 일치하면 사용자정보확인(get)
    }
}
