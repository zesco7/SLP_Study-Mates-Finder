//
//  CertificationViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import Firebase
import RxCocoa
import RxSwift

class CertificationViewModel: CommonMethods {
    var baseView = BaseView()
    
    var certificationEvent = PublishRelay<Bool>()
    var isValidCertification: Bool = false
    var certificationCode: String = ""
    
    func certificationValidation(code: String) {
        let regularExpression = "^([0-9]{6})$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        let isValid = predicate.evaluate(with: code)
        certificationCode = code
        isValidCertification = isValid
        certificationEvent.accept(isValidCertification)
    }
    
    func retryButtonTapped() {
        let phoneNumber = SignUpUserDefaults.phoneNumber.userDefaults
        let startIndex = phoneNumber.index(phoneNumber.startIndex, offsetBy: 3)
        FirebaseRequest.requestVerificationCode(phoneNumber: phoneNumber)
    }
    
    func buttonTapped(_ viewController: UIViewController){
        if isValidCertification {
            //서버에 인증번호일치확인 통신요청(post)
            //인증번호 일치하면 사용자정보확인(get)
            /*
             1. 인증번호 요청하여 임시토큰 발급
             2. 임시토큰과 인증코드 서버에 보내서 사용자 정보 확인되면 진짜토큰 발급
             3. 진짜토큰을 헤더파일에 넣어서 서버에 로그인 정보 확인(이때 기존사용자면 홈화면, 신규사용자면 닉네임 입력화면으로 전환)
             */
            
            UserDefaults.standard.set(certificationCode, forKey: "certification")
            print("certi ud", SignUpUserDefaults.certification.userDefaults)
            transitionToNicknameViewController(viewController)
//            verifyRequest(viewController)
            print("인증요청 가능")
        } else {
            viewController.view.makeToast(SignUpToastMessages.certification.messages, duration: 1, position: .top)
        }
    }
    
    func transitionToNicknameViewController(_ viewController: UIViewController) {
        let vc = NicknameViewController(mainView: NicknameView())
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
        
    func verifyRequest(_ viewController: UIViewController) {
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: SignUpUserDefaults.authVerificationID.userDefaults, verificationCode: SignUpUserDefaults.certification.userDefaults)

        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error as NSError? {
                guard let errorCode = AuthErrorCode.Code(rawValue: error.code) else { return }
                switch errorCode {
                case .sessionExpired, .invalidVerificationCode:
                    viewController.view.makeToast(FirebaseToastMessages.failureVerified.messages, duration: 1, position: .top)
                    return
                default:
                    viewController.view.makeToast(FirebaseToastMessages.errorExceptFailure.messages, duration: 1, position: .top)
                    return
                }
            }

            //MARK: - ID 토큰 발급
//            authResult?.user.getIDToken { token, error in
//                if let error = error {
//                    viewController.view.makeToast("에러: \(error.localizedDescription)", duration: 1, position: .top)
//                    return
//                }
//                guard let token = token else { return }
//                UserDefaults.standard.set(token, forKey: "serverToken")
//                //MARK: - 로그인 API 요청
//                APIService.login { value, statusCode, error in
//                    guard let statusCode = statusCode else { return }
//                    print(statusCode)
//                    switch statusCode {
//                    case 200:
//                        //MARK: - 로그인 성공 시 닉네임 값 받아오기
//                        print("로그인 성공")
//                        return
//                    case 401: self.refreshToken(viewController)
//                        return
//                    case 406:
//                        print("미가입 유저로 회원가입 화면으로 이동합니다.")
//                        //닉네임 화면으로 이동
//                        self.transitionToNicknameViewController(viewController)
//                        return
//                    default: print("잠시 후 다시 시도해주세요.")
//                        return
//                    }
//                }
//            }
        }
    }

    func refreshToken(_ viewController: UIViewController) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print("error : ", error)
                return;
            } else if let idToken = idToken {
                print("idToken : ", idToken)
                APIService.login { value, statusCode, error in
                    guard let statusCode = statusCode else { return }
                    print(statusCode)
                    switch statusCode {
                    case 200:
                        //MARK: - 로그인 성공 시 닉네임 값 받아오기
                        print("로그인 성공")
                        return
                    case 406:
                        print("미가입 유저로 회원가입 화면으로 이동합니다.")
                        self.transitionToNicknameViewController(viewController)
                        return
                    default: print("잠시 후 다시 시도해주세요.")
                        return
                    }
                }
            }
        }
    }
}
