//
//  CustomTextField.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/09.
//

import UIKit
import SnapKit

class CustomTextField: UITextField {
    //plain, auth, password
    let phoneNumberTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        return view
    }()
    
    let certificationTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "인증번호 입력"
        view.keyboardType = .decimalPad
        return view
    }()
    
    let nicknameTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "10자 이내로 입력"
        return view
    }()
    
    let birthTextField: UITextField = {
        let view = UITextField()
        view.keyboardType = .decimalPad
        return view
    }()
    
    let emailTextField: UITextField = {
        let view = UITextField()
        return view
    }()
}


