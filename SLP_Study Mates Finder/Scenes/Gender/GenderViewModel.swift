//
//  GenderViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import Firebase
import RxCocoa
import RxSwift

class GenderViewModel {
    var baseView = BaseView()
    let disposeBag = DisposeBag()
    
    var genderCodeEvent = PublishRelay<Int>()
    var genderCode: Int = 2
    var statusCodePublisher = PublishRelay<Int>()
    var tokenErrorPublisher = PublishRelay<NSError>()
    
    func genderValidation(_ gender: Int) {
        genderCode = gender
        genderCodeEvent.accept(genderCode)
    }
    
    func maleButtonTapped(mainView: GenderView) {
        mainView.maleButton.rx.tap.asDriver()
            .drive(with: mainView.maleButton) { [self] button, _ in
                self.genderCode = 1
                self.genderValidation(genderCode)
                UserDefaults.standard.set(genderCode, forKey: SignUpUserDefaults.gender.rawValue)
            }
            .disposed(by: disposeBag)
    }
    
    func femaleButtonTapped(mainView: GenderView) {
        mainView.femaleButton.rx.tap.asDriver()
            .drive(with: mainView.femaleButton) { [self] button, _ in
                self.genderCode = 0
                self.genderValidation(genderCode)
                UserDefaults.standard.set(genderCode, forKey: SignUpUserDefaults.gender.rawValue)
            }
            .disposed(by: disposeBag)
    }

    func requestSignUp() {
        APIService.signUp { value, statusCode, error in
            guard let statusCode = statusCode else { return }
            self.statusCodePublisher.accept(statusCode)
        }
    }
    
    func refreshToken() {
        //MARK: - ID 토큰 재발급
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error as NSError? {
                print("error : ", error)
                self.tokenErrorPublisher.accept(error)
                return;
            } else if let idToken = idToken {
                print("idToken : ", idToken)
                UserDefaults.standard.set(("idToken : ", idToken), forKey: SignUpUserDefaults.idToken.rawValue)
                
                //MARK: - 재발급받은 토큰을 헤더파일로 보내서 회원가입 API 재요청
                self.requestSignUp()
            }
        }
    }
}
