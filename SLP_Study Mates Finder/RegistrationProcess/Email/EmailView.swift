//
//  EmailView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import Foundation
import UIKit

class EmailView: BaseView {
    let emailIntroduction: RegistrationProcessLabel = {
       let view = RegistrationProcessLabel()
        view.text = "이메일을 입력해주세요"
        return view
    }()
    
    let emailDetailIntroduction: RegistrationProcessDetailLabel = {
       let view = RegistrationProcessDetailLabel()
        view.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        return view
    }()
    
    let emailTextField: UITextField = {
       let view = UITextField()
        view.placeholder = "10자 이내로 입력"
        view.textColor = .black
        view.borderStyle = .none

        return view
    }()
    
    let emailPassButton: LargeButton = {
        let view = LargeButton()
        view.setTitle("다음", for: .normal)
        return view
    }()
    
    override func configure() {
        [emailIntroduction, emailDetailIntroduction, emailTextField, emailPassButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        emailIntroduction.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(50)
            make.centerY.equalTo(self).multipliedBy(0.4)
        }
        
        emailDetailIntroduction.snp.makeConstraints { make in
            make.leadingMargin.equalTo(30)
            make.trailingMargin.equalTo(-30)
            make.height.equalTo(50)
            make.bottom.equalTo(emailTextField.snp.top).offset(-30)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(emailPassButton.snp.top).offset(-60)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        emailPassButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}

