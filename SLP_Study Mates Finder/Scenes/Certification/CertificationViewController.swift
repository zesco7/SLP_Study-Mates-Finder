//
//  CertificationViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/11.
//

import UIKit
import Firebase
import FirebaseAuth
import RxCocoa
import RxSwift

class CertificationViewController: UIViewController {
    var mainView: CertificationView
    let viewModel = CertificationViewModel()
    let disposeBag = DisposeBag()

    init(mainView: CertificationView) {
        self.mainView = mainView
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        self.view = mainView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldAttribute()
        bind()
        activateAction()
    }
    
    override func viewDidLayoutSubviews() { mainView.textFieldBorderAttribute() }
    
    func textFieldAttribute() {
        mainView.certificationTextField.delegate = self
    }
    
    func bind() {
        viewModel.certificationEvent.asDriver(onErrorJustReturn: false)
            .drive(with: mainView.certificationButton) { button, data in
                if data {
                    self.mainView.certificationButton.green()
                    self.mainView.certificationButton.isEnabled = true
                } else {
                    self.mainView.certificationButton.gray6()
                    self.mainView.certificationButton.isEnabled = false
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.authErrorPublisher
            .withUnretained(self)
            .subscribe(onNext: { error in
                self.view.makeToast(FirebaseToastMessages.failureVerified.messages, duration: 1, position: .top)
                self.pushScene()
            })
            .disposed(by: disposeBag)
        
        viewModel.tokenErrorPublisher
            .subscribe(onNext: { error in
                self.view.makeToast("에러: \(error.localizedDescription)", duration: 1, position: .top)
            })
            .disposed(by: disposeBag)
        
        viewModel.tokenPublisher
            .withUnretained(self)
            .subscribe(onNext: { token in
                self.viewModel.requestLogin()
            })
            .disposed(by: disposeBag)
        
        viewModel.statusCodePublisher
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { statusCode in
                switch statusCode {
                case 200:
                    //MARK: - 로그인 성공하면 회원정보 데이터 받고 서비스 홈화면 이동
                    print("로그인 성공")
                    Methods.moveToHome()
                    return
                case 401:
                    //MARK: - ID 토큰 재발급
                    print("토큰을 재발급합니다.")
                    self.viewModel.refreshToken()
                    return
                case 406:
                    print("미가입 유저이므로 회원가입 화면으로 이동합니다.")
                    self.pushScene()
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
            })
            .disposed(by: disposeBag)
    }
    
    func activateAction() {
        mainView.certificationTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
        mainView.retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        mainView.certificationButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func pushScene() {
        let baseViewToChange = NicknameView()
        let vc = NicknameViewController(mainView: baseViewToChange)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func textFieldEditing() {
        guard let text = mainView.certificationTextField.text else { return }
        viewModel.certificationValidation(code: text)
    }
    
    @objc func retryButtonTapped() { viewModel.retryButtonTapped() }
    
    @objc func buttonTapped() { viewModel.verifyRequest() }
}

extension CertificationViewController: UITextFieldDelegate { }
