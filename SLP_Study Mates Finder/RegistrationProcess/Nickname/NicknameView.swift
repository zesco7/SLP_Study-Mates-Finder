//
//  NicknameView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import Foundation
import UIKit

class NicknameView: BaseView {
    let nicknameIntroduction: RegistrationProcessLabel = {
       let view = RegistrationProcessLabel()
        view.text = "닉네임을 입력해주세요"
        return view
    }()
    
    let nicknameTextField: UITextField = {
       let view = UITextField()
        view.placeholder = "10자 이내로 입력"
        view.textColor = .black
        view.borderStyle = .none

        return view
    }()
    
    let nicknamePassButton: LargeButton = {
        let view = LargeButton()
        view.setTitle("다음", for: .normal)
        return view
    }()
    
    override func configure() {
        [nicknameIntroduction, nicknameTextField, nicknamePassButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        nicknameIntroduction.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(50)
            make.centerY.equalTo(self).multipliedBy(0.4)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(nicknamePassButton.snp.top).offset(-60)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        nicknamePassButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}
