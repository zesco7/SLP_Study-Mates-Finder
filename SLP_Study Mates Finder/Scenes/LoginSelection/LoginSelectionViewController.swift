//
//  LoginSelectionViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/04/12.
//

import UIKit

class LoginSelectionViewController: UIViewController {
    var mainView = LoginSelectionView()
    
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
    }
    
    func moveToHome(_ viewController: UIViewController) {
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        viewController.present(vc, animated: true)
    }
    
    @objc func signUpButtonTapped() {
        let vc = PhoneNumberViewController(mainView: PhoneNumberView())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func googleLoginButtonTapped() {
        //인증 후 홈화면 이동
        moveToHome(self)
    }
    
    @objc func appleLoginButtonTapped() {
        //인증 후 홈화면 이동
        moveToHome(self)
    }
    
    @objc func kakaoLoginButtonTapped() {
        //인증 후 홈화면 이동
        moveToHome(self)
    }
    
    @objc func naverLoginButtonTapped() {
        //인증 후 홈화면 이동
        moveToHome(self)
    }
}
