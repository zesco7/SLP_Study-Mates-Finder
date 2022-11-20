//
//  BirthView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import Foundation
import UIKit
import SwiftUI

class BirthView: BaseView {
    let birthIntroduction: RegistrationProcessLabel = {
        let view = RegistrationProcessLabel()
        view.text = "생년월일을 알려주세요"
        return view
    }()
    
    let birthYearTextField: UITextField = {
        let view = UITextField()
        view.textColor = .black
        view.borderStyle = .none
        view.textAlignment = .center
        return view
    }()
    
    let birthYearLabel: UILabel = {
        let view = UILabel()
        view.text = "년"
        view.font = .systemFont(ofSize: 16)
        view.black()
        return view
    }()
    
    let birthMonthTextField: UITextField = {
        let view = UITextField()
        view.textColor = .black
        view.borderStyle = .none
        view.textAlignment = .center
        return view
    }()
    
    let birthMonthLabel: UILabel = {
        let view = UILabel()
        view.text = "월"
        view.font = .systemFont(ofSize: 16)
        view.black()
        return view
    }()
    
    let birthDayTextField: UITextField = {
        let view = UITextField()
        view.textColor = .black
        view.borderStyle = .none
        view.textAlignment = .center
        return view
    }()
    
    let birthDayLabel: UILabel = {
        let view = UILabel()
        view.text = "일"
        view.font = .systemFont(ofSize: 16)
        view.black()
        return view
    }()
    
    let birthPassButton: LargeButton = {
        let view = LargeButton()
        view.setTitle("다음", for: .normal)
        return view
    }()
    
    override func configure() {
        [birthIntroduction, birthYearTextField, birthYearLabel, birthMonthTextField, birthMonthLabel, birthDayTextField, birthDayLabel, birthPassButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        birthIntroduction.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(50)
            make.centerY.equalTo(self).multipliedBy(0.4)
        }
        
        birthYearTextField.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(30)
            make.leadingMargin.equalTo(20)
            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
        }
        
        birthYearLabel.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.leading.equalTo(birthYearTextField.snp.trailing).offset(1)
            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
        }
        
        birthMonthTextField.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(30)
            make.centerX.equalTo(self).offset(-10)
            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
        }
        
        birthMonthLabel.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.leading.equalTo(birthMonthTextField.snp.trailing).offset(1)
            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
        }
        
        birthDayTextField.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(30)
            make.trailing.equalTo(birthDayLabel.snp.leading).offset(1)
            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
        }
        
        birthDayLabel.snp.makeConstraints { make in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
        }
        
        birthPassButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}
