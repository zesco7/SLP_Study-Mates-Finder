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

class GenderViewModel: CommonMethods {
    var baseView = BaseView()
    let disposeBag = DisposeBag()
    
    var genderCodeEvent = PublishRelay<Int>()
    var genderCode: Int = 2
    
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
    
    func buttonTapped(_ viewController: UIViewController){
        //유저정보 한번에 넘기고 결과에 따라 화면전환
        print(UserDefaultsHelper())
        APIService.signUp { value, statusCode, error in
            guard let statusCode = statusCode else { return }
            switch statusCode {
            case 200:
                print("회원가입 성공, 홈 화면으로 이동합니다.")
                Methods.moveToHome()
                return
            case 201:
                print("이미 가입한 유저입니다.")
                return
            case 202:
                print("사용할 수 없는 닉네임입니다. 닉네임 변경 후 다시 회원가입 요청해주세요.")
                return
            case 401:
                print("Firebase Token Error")
                refreshToken()
                return
            case 500:
                print("Server Error")
                return
            case 501:
                print("Client Error, API 요청시 Header와 RequestBody에 값을 확인해주세요.")
                return
            default: print("잠시 후 다시 시도해주세요.")
                return
            }
        }
        
        func refreshToken() {
            //MARK: - ID 토큰 재발급
            let currentUser = Auth.auth().currentUser
            currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
                if let error = error {
                    print("error : ", error)
                    return;
                } else if let idToken = idToken {
                    print("idToken : ", idToken)
                    UserDefaults.standard.set(("idToken : ", idToken), forKey: SignUpUserDefaults.idToken.rawValue)
                    
                    //MARK: - 재발급받은 토큰을 헤더파일로 보내서 회원가입 API 요청
                    APIService.signUp { value, statusCode, error in
                        guard let statusCode = statusCode else { return }
                        print(statusCode)
                        switch statusCode {
                        case 200:
                            print("회원가입 성공, 홈 화면으로 이동합니다.")
                            Methods.moveToHome()
                            return
                        case 201:
                            print("이미 가입한 유저입니다.")
                            return
                        case 202:
                            print("사용할 수 없는 닉네임입니다. 닉네임 변경 후 다시 회원가입 요청해주세요.")
                            return
                        case 500:
                            print("Server Error")
                            return
                        case 501:
                            print("Client Error, API 요청시 Header와 RequestBody에 값을 확인해주세요.")
                            return
                        default: print("잠시 후 다시 시도해주세요.")
                            return
                        }
                    }
                }
            }
        }
    }
}

