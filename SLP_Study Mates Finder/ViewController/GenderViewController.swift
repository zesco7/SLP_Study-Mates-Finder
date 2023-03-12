//
//  GenderViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift

class GenderViewController: UIViewController {
    var mainView: GenderView
    let viewModel = GenderViewModel()
    let disposeBag = DisposeBag()
    let border = CALayer()
    let genderCode = BehaviorSubject<Int>(value: 2)
    
    init(mainView: GenderView) {
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
        
        bind()
        sendGenderEvent()
        activateAction()
        
//        mainView.maleButton.rx.tap.asDriver()
//            .drive(with: mainView.maleButton) { button ,_ in
//                button.whiteGreen()
//            }
//            .disposed(by: disposeBag)
//        
//        mainView.femaleButton.rx.tap.asDriver()
//            .drive(with: mainView.femaleButton) { button ,_ in
//                button.whiteGreen()
//            }
//            .disposed(by: disposeBag)
//
    }
    
    func bind() {
        //disposebag 어떻게?
        viewModel.genderCodeEvent.asDriver(onErrorJustReturn: 2)
            .drive { genderCode in
                if genderCode == 0 {
                    self.mainView.femaleButton.whiteGreen()
                    self.mainView.maleButton.backgroundColor = .white
                    self.mainView.genderButton.green()
                } else if genderCode == 1 {
                    self.mainView.maleButton.whiteGreen()
                    self.mainView.femaleButton.backgroundColor = .white
                    self.mainView.genderButton.green()
                } else {
                    self.mainView.maleButton.backgroundColor = .white
                    self.mainView.femaleButton.backgroundColor = .white
                }
            }
    }
    
    func sendGenderEvent() {
        viewModel.maleButtonTapped(mainView: mainView)
        viewModel.femaleButtonTapped(mainView: mainView)
    }
    
    func activateAction() { mainView.genderButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside) }
    
    @objc func buttonTapped() {
        viewModel.buttonTapped(self)
    
        APIService.signUp { value, statusCode, error in
            if let statusCode = statusCode {
                print("Network Request by AuthenticToken", statusCode)
                self.refreshToken()
            } else {
                print("응답코드 에러")
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
                APIService.signUpByServerToken { value, status, error in
                    print("Network Request by refreshToken", status)
                    print("value : ", value)
                }
            }
        }
    }
}
