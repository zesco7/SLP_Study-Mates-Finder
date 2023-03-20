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

class CertificationViewModel {
    var baseView = BaseView()
    
    var certificationEvent = PublishRelay<Bool>()
    var isValidCertification: Bool = false
    var certificationCode: String = ""
    var statusCodePublisher = PublishRelay<Int>()
    var tokenPublisher = PublishRelay<String>()
    var tokenErrorPublisher = PublishRelay<NSError>()
    var authErrorPublisher = PublishRelay<NSError>()
    var signUpData: SignUpData = SignUpData()
    
    var disposeBag = DisposeBag()
    
    func certificationValidation(code: String) {
        let regularExpression = "^([0-9]{6})$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regularExpression)
        let isValid = predicate.evaluate(with: code)
        certificationCode = code
        isValidCertification = isValid
        certificationEvent.accept(isValidCertification)
    }
    
    func retryButtonTapped() {
        FirebaseRequest.requestVerificationCode(phoneNumber: "+82 \(signUpData.phoneNumber)")
            .subscribe(onNext: { verificationID in
                self.signUpData.authVerificationID = verificationID
            }, onError: { error in
            })
            .disposed(by: disposeBag)
    }
    
    func verifyRequest() {
        signUpData.certification = certificationCode
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: signUpData.authVerificationID, verificationCode: signUpData.certification)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error as NSError? {
                guard let errorCode = AuthErrorCode.Code(rawValue: error.code) else { return }
                switch errorCode {
                case .sessionExpired, .invalidVerificationCode:
                    self.authErrorPublisher.accept(error) //인증코드 불일치
                    return
                default:
                    return
                }
            }
            
            //MARK: - ID 토큰 발급
            authResult?.user.getIDToken { token, error in
                if let error = error as NSError? {
                    self.tokenErrorPublisher.accept(error) //인증코드 일치하지만 서버 상태 등으로 에러가 나는 경우
                    return
                }
                guard let token = token else { return }
                self.tokenPublisher.accept(token) //인증코드 일치하여 토큰발급
                UserDefaults.standard.set(token, forKey: SignUpUserDefaults.idToken.rawValue)
                print("토큰 저장", SignUpUserDefaults.idToken.userDefaults)
            }
        }
    }
    
    func requestLogin() {
        //MARK: - 발급받은 토큰을 헤더파일로 보내서 로그인 API 요청
        APIService.login { value, statusCode, error in
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
                self.tokenPublisher.accept(idToken)
                UserDefaults.standard.set(idToken, forKey: SignUpUserDefaults.idToken.rawValue)
                
                //MARK: - 재발급받은 토큰을 헤더파일로 보내서 로그인 API 요청
                self.requestLogin()
            }
        }
    }
}
