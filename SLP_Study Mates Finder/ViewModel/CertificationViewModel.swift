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
            UserDefaults.standard.set(certificationCode, forKey: "certification")
//            verifyRequest(viewController)
            Methods.moveToNickname()
        } else {
            viewController.view.makeToast(SignUpToastMessages.certification.messages, duration: 1, position: .top)
        }
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
            authResult?.user.getIDToken { token, error in
                if let error = error {
                    viewController.view.makeToast("에러: \(error.localizedDescription)", duration: 1, position: .top)
                    return
                }
                guard let token = token else { return }
                UserDefaults.standard.set(token, forKey: SignUpUserDefaults.idToken.rawValue)
                print("토큰 여기있음", SignUpUserDefaults.idToken.userDefaults)
                
                //MARK: - 발급받은 토큰을 헤더파일로 보내서 로그인 API 요청
                APIService.login { value, statusCode, error in
                    guard let statusCode = statusCode else { return }
                    print(statusCode)
                    switch statusCode {
                    case 200:
                        //MARK: - 로그인 성공하면 회원정보 데이터 받고 서비스 홈화면 이동
                        print("로그인 성공")
                        Methods.moveToHome()
                        return
                    case 401:
                        //MARK: - ID 토큰 재발급
                        self.refreshToken(viewController)
                        return
                    case 406:
                        print("미가입 유저이므로 회원가입 화면으로 이동합니다.")
                        Methods.moveToNickname()
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

    func refreshToken(_ viewController: UIViewController) {
        //MARK: - ID 토큰 재발급
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print("error : ", error)
                return;
            } else if let idToken = idToken {
                print("idToken : ", idToken)
                UserDefaults.standard.set(("idToken : ", idToken), forKey: SignUpUserDefaults.idToken.rawValue)
                
                //MARK: - 재발급받은 토큰을 헤더파일로 보내서 로그인 API 요청
                APIService.login { value, statusCode, error in
                    guard let statusCode = statusCode else { return }
                    print(statusCode)
                    switch statusCode {
                    case 200:
                        //MARK: - 로그인 성공하면 회원정보 데이터 받고 서비스 홈화면 이동
                        print("로그인 성공")
                        Methods.moveToHome()
                        return
                    case 406:
                        print("미가입 유저로 회원가입 화면으로 이동합니다.")
                        Methods.moveToNickname()
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
