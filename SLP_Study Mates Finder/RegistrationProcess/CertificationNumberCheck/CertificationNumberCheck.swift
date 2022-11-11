//
//  CertificationNumberCheck.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import Foundation
import UIKit

class CertificationNumberCheck: BaseView {
    let phoneNumberCheckIntroduction: RegistrationProcessLabel = {
       let view = RegistrationProcessLabel()
        view.text = "인증 번호가 문자로 전송되었어요"
        return view
    }()
    
    let phoneNumberTextField: UITextField = {
       let view = UITextField()
        view.placeholder = "인증번호 입력"
        view.keyboardType = .decimalPad
        view.textColor = .black
        view.borderStyle = .none

        return view
    }()
    
    let requestTextButton: LargeButton = {
        let view = LargeButton()
        view.setTitle("재전송", for: .normal)
        view.green()
        return view
    }()
    
    let certificationStartButton: LargeButton = {
        let view = LargeButton()
        view.setTitle("인증하고 시작하기", for: .normal)
        return view
    }()
    
    override func configure() {
        [phoneNumberCheckIntroduction, phoneNumberTextField, requestTextButton, certificationStartButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        phoneNumberCheckIntroduction.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(100)
            make.bottom.equalTo(phoneNumberTextField.snp.top).offset(-60)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.bottom.equalTo(certificationStartButton.snp.top).offset(-60)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-120)
            make.height.equalTo(50)
        }
        
        requestTextButton.snp.makeConstraints { make in
            make.bottom.equalTo(certificationStartButton.snp.top).offset(-60)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        certificationStartButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}
