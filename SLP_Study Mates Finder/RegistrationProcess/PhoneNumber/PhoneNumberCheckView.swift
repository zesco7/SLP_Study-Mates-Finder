//
//  PhoneNumberCheckView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import Foundation
import UIKit

class PhoneNumberCheckView: BaseView {
    let phoneNumberCheckIntroduction: RegistrationProcessLabel = {
       let view = RegistrationProcessLabel()
        view.text = "새싹 서비스 이용을 위해 휴대폰 번호를 입력해 주세요"
        return view
    }()
    
    let phoneNumberTextField: UITextField = {
       let view = UITextField()
        view.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        view.keyboardType = .decimalPad
        view.textColor = .black
        view.borderStyle = .none

        return view
    }()
    
    let receiveTextButton: LargeButton = {
        let view = LargeButton()
        view.setTitle("인증 문자 받기", for: .normal)
        return view
    }()
    
    override func configure() {
        [phoneNumberCheckIntroduction, phoneNumberTextField, receiveTextButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        phoneNumberCheckIntroduction.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(50)
            make.centerY.equalTo(self).multipliedBy(0.4)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(receiveTextButton.snp.top).offset(-60)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        receiveTextButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}
