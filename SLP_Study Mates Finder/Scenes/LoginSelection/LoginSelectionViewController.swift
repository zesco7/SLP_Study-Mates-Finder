//
//  LoginSelectionViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/04/12.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth
import Toast

class LoginSelectionViewController: UIViewController {
    var mainView = LoginSelectionView()
    var kakaoToken: String?

    init(mainView: LoginSelectionView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateAction()
        
    }
    
    func activateAction() {
        mainView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        mainView.googleLoginButton.addTarget(self, action: #selector(googleLoginButtonTapped), for: .touchUpInside)
        mainView.appleLoginButton.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
        mainView.kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
        mainView.naverLoginButton.addTarget(self, action: #selector(naverLoginButtonTapped), for: .touchUpInside)
        mainView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    func moveToHome() {
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func signUpButtonTapped() {
        let vc = PhoneNumberViewController(mainView: PhoneNumberView())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func googleLoginButtonTapped() {
        //인증 후 홈화면 이동
        moveToHome()
    }
    
    @objc func appleLoginButtonTapped() {
        //인증 후 홈화면 이동
        moveToHome()
    }
    
    @objc func kakaoLoginButtonTapped() {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    _ = oauthToken
                    self.kakaoToken = oauthToken?.accessToken
                    print("kakaoToken created", self.kakaoToken)
                    self.moveToHome()
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    _ = oauthToken
                    self.kakaoToken = oauthToken?.accessToken
                    print("kakaoToken created", self.kakaoToken)
                    self.moveToHome()
                }
            }
        }
    }
    
    @objc func naverLoginButtonTapped() {
        //인증 후 홈화면 이동
        moveToHome()
    }
    
    @objc func logoutButtonTapped() {
        print("kakaoToken", kakaoToken)
        unlinkKakao()
//        if kakaoToken != nil {
//            self.view.makeToast("로그아웃 되었습니다.", duration: 1.0, position: .bottom)
//        } else {
//            self.view.makeToast("로그인 상태가 아닙니다.", duration: 1.0, position: .bottom)
//        }
    }
    
    func unlinkKakao() {
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                self.kakaoToken = nil
                print("kakaoToken deleted", self.kakaoToken)
                print("unlink() success.")
            }
        }
    }
}
