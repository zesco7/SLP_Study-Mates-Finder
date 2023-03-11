//
//  CertificationCustomTextField.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/11.
//

import UIKit
import SnapKit

class CertificationCustomTextField: UITextField {
    let certificationTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "인증번호 입력"
        view.keyboardType = .decimalPad
        return view
    }()
}



