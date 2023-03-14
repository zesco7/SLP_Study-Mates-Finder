//
//  GenderViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
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
        //        let baseViewToChange = NicknameView()
        //        let vc = NicknameViewController(mainView: baseViewToChange)
        //        viewController.navigationController?.pushViewController(vc, animated: true)    }
        
        print(SignUpUserDefaults.phoneNumber.userDefaults)
        print(SignUpUserDefaults.certification.userDefaults)
        print(SignUpUserDefaults.nickname.userDefaults)
        print(SignUpUserDefaults.birth.userDefaults)
        print(SignUpUserDefaults.email.userDefaults)
        print(SignUpUserDefaults.gender.userDefaults)
    }
}


