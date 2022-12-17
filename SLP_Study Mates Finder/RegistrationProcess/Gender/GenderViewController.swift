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

class GenderViewController: BaseViewController {
    var mainView = GenderView()
    let border = CALayer()
    let genderCode = BehaviorSubject<Int>(value: 2)
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderAddTargetCollection()
        genderValidation()
        
        //var genderSelection = UserDefaults.standard.set(genderCode, forKey: "genderSelection")
        
    }
    
    func genderAddTargetCollection() {
        mainView.maleButton.addTarget(self, action: #selector(maleButtonClicked), for: .touchDown)
        mainView.femaleButton.addTarget(self, action: #selector(femaleButtonClicked), for: .touchDown)
        mainView.genderPassButton.addTarget(self, action: #selector(genderPassButtonClicked), for: .touchUpInside)
    }
    
    func genderValidation() {
        genderCode
            .bind(onNext: { value in
                if value == 2 {
                    self.mainView.genderPassButton.gray6()
                } else {
                    self.mainView.genderPassButton.green()
                }
            })
            .disposed(by: disposeBag)
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
                    print("value : ", value)
                }
            }
        }
    }
    
    @objc func maleButtonClicked() {
        UserDefaults.standard.set("1", forKey: "genderSelection")
        if mainView.maleButton.backgroundColor == .white && mainView.femaleButton.backgroundColor == .white  {
            mainView.maleButton.whiteGreen()
            mainView.maleButton.layer.borderColor = .none
        } else {
            mainView.maleButton.backgroundColor = .white
        }
    }
    
    @objc func femaleButtonClicked() {
        UserDefaults.standard.set("0", forKey: "genderSelection")
        if mainView.maleButton.backgroundColor == .white && mainView.femaleButton.backgroundColor == .white {
            mainView.femaleButton.whiteGreen()
            mainView.femaleButton.layer.borderColor = .none
        } else {
            mainView.femaleButton.backgroundColor = .white
        }
    }
    
    @objc func genderPassButtonClicked() {
        print(UserDefaults.standard.string(forKey: "genderSelection")!)
        
        APIService.signUp { value, statusCode, error in
            if let statusCode = statusCode {
                self.refreshToken()
            }
            print(statusCode)
            
            
            //        let vc = BirthViewController()
            //        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
