//
//  CertificationNumberCheckViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift

class CertificationNumberCheckViewController: BaseViewController {
    var mainView = CertificationNumberCheck()
    let border = CALayer()
    let viewModel = CertificationNumberCheckViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.checkValidation(code: mainView.certificationNumberCheckTextField.text!)
        certificationAddTargetCollection()
        certificationTextButtonColorChange()
        
        certificationValidation(number: "123456")
        certificationValidation(number: "1234567")
        //certificationValidation(number: mainView.certificationNumberCheckTextField.rx.text)
        
    }
    
    func certificationAddTargetCollection() {
        mainView.certificationStartButton.addTarget(self, action: #selector(certificationStartButtonClicked), for: .touchUpInside)
    }
    
    func certificationTextButtonColorChange() {
        mainView.certificationNumberCheckTextField.rx.text
            .map { $0!.count == 6 }
            .withUnretained(self)
            .bind { (vc, value) in
                value ? self.mainView.certificationStartButton.green() : self.mainView.certificationStartButton.gray6()
            }
    }
    
    func certificationValidation(number: String) -> Bool {
        let regex = "^[0-9]{6}$"
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: number)
    }

    func requestVerification() {
        var verificationNumber = self.mainView.certificationNumberCheckTextField.text
        UserDefaults.standard.set(verificationNumber, forKey: "verificationCode")
        
        var authVerificationID = UserDefaults.standard.string(forKey: "authVerificationID")!
        var verificationCode = UserDefaults.standard.string(forKey: "verificationCode")!
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: authVerificationID, verificationCode: verificationCode)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error as NSError? {
                guard let errorCode = AuthErrorCode.Code(rawValue: error.code) else { return }
                switch errorCode {
                case .sessionExpired, .invalidVerificationCode:
                    self.view.makeToast("전화 번호 인증 실패", duration: 1, position: .top)
                    return
                default:
                    self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요.", duration: 1, position: .top)
                    return
                }
            }
            
            //MARK: - ID 토큰 발급
            authResult?.user.getIDToken { token, error in
                if let error = error {
                    self.view.makeToast("에러: \(error.localizedDescription)", duration: 1, position: .top)
                    return
                }
                guard let token = token else { return }
                UserDefaults.standard.set(token, forKey: "serverToken")
                //MARK: - 로그인 API 요청
                APIService.loginByServerToken { value, statusCode, error in
                    guard let statusCode = statusCode else { return }
                    print(statusCode)
                    switch statusCode {
                    case 200:
                        //MARK: - 로그인 성공 시 닉네임 값 받아오기
                        print("로그인 성공")
                        return
                    case 401: self.refreshToken()
                        return
                    case 406:
                        print("미가입 유저로 회원가입 화면으로 이동합니다.")
                        let vc = NicknameViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        return
                    default: print("잠시 후 다시 시도해주세요.")
                        return
                    }
                }
            }
        }
    }
    
    func refreshToken() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            if let error = error {
                print("error : ", error)
                return;
            } else if let idToken = idToken {
                print("idToken : ", idToken)
                APIService.loginByServerToken { value, statusCode, error in
                    guard let statusCode = statusCode else { return }
                    print(statusCode)
                    switch statusCode {
                    case 200:
                        //MARK: - 로그인 성공 시 닉네임 값 받아오기
                        print("로그인 성공")
                        return
                    case 406:
                        print("미가입 유저로 회원가입 화면으로 이동합니다.")
                        let vc = NicknameViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        return
                    default: print("잠시 후 다시 시도해주세요.")
                        return
                    }
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.certificationNumberCheckTextField.frame.size.height-1, width: mainView.certificationNumberCheckTextField.frame.width, height: 1)
        border.gray3()
        mainView.certificationNumberCheckTextField.layer.addSublayer((border))
    }
    
    @objc func certificationStartButtonClicked() {
        if mainView.certificationNumberCheckTextField.text?.count == 6 {
            /*
             1. 인증번호 요청하여 임시토큰 발급
             2. 임시토큰과 인증코드 서버에 보내서 사용자 정보 확인되면 진짜토큰 발급
             3. 진짜토큰을 헤더파일에 넣어서 서버에 로그인 정보 확인(이때 기존사용자면 홈화면, 신규사용자면 닉네임 입력화면으로 전환)
             */
            requestVerification()
            print("인증요청 가능")
        } else {
            self.view.makeToast("전화 번호 인증 실패", duration: 1, position: .top)
        }
    }
}
