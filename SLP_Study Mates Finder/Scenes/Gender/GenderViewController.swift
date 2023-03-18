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
        
        viewModel.tokenErrorPublisher
            .subscribe(onNext: { error in
                self.view.makeToast("에러: \(error.localizedDescription)", duration: 1, position: .top)
            })
            .disposed(by: disposeBag)
        
        viewModel.statusCodePublisher
            .subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { statusCode in
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
                    Methods.moveToNickname()
                    return
                case 401:
                    print("Firebase Token Error")
                    self.viewModel.refreshToken()
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
    
    func sendGenderEvent() {
        viewModel.maleButtonTapped(mainView: mainView)
        viewModel.femaleButtonTapped(mainView: mainView)
    }
    
    func activateAction() { mainView.genderButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside) }
    
    @objc func buttonTapped() { viewModel.requestSignUp() }
}
