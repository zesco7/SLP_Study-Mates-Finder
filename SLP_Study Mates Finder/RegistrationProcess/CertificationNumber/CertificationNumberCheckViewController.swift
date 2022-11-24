//
//  CertificationNumberCheckViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit

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
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.certificationNumberCheckTextField.frame.size.height-1, width: mainView.certificationNumberCheckTextField.frame.width, height: 1)
        border.gray3()
        mainView.certificationNumberCheckTextField.layer.addSublayer((border))
    }
    
    @objc func certificationStartButtonClicked() {
        if mainView.certificationNumberCheckTextField.text?.count == 6 {
            /*
             인증 번호 일치 이후 Firebase ID 토큰 요청 후 ID 토큰을 성공적으로 받은 경우
             서버로부터 사용자 정보를 확인 : (get, /v1/user)
             기존 사용자 → 홈 화면(1_1_main_default)
             신규 사용자 → 닉네임 입력 화면으로 전환(0_3_nickname
             */
            print("인증요청 가능")
        } else {
            self.view.makeToast("전화 번호 인증 실패", duration: 1, position: .top)
        }
        
//        let vc = NicknameViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
