//
//  GenderView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import Foundation
import UIKit

class GenderView: BaseView {
    let genderIntroduction: RegistrationProcessLabel = {
       let view = RegistrationProcessLabel()
        view.text = SignUpMessages.gender.messages
        return view
    }()
    
    let genderDetailIntroduction: RegistrationProcessDetailLabel = {
       let view = RegistrationProcessDetailLabel()
        view.text = SignUpMessages.gender.subMessages
        return view
    }()
    
    let maleButton: UIButton = {
       let view = UIButton()
        view.setTitle("남자", for: .normal)
        view.titleLabel?.textColor = .black
        view.backgroundColor = .white
        view.setImage(UIImage(named: "male_button"), for: .normal)
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let femaleButton: UIButton = {
        let view = UIButton()
        view.setTitle("여자", for: .normal)
        view.titleLabel?.textColor = .black
        view.backgroundColor = .white
        view.setImage(UIImage(named: "female_button"), for: .normal)
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()

    let genderPassButton: LargeButton = {
        let view = LargeButton()
        view.setTitle(ButtonMessages.restPages.messages, for: .normal)
        return view
    }()
    
    override func configure() {
        [genderIntroduction, genderDetailIntroduction, maleButton, femaleButton, genderPassButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        genderIntroduction.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(50)
            make.centerY.equalTo(self).multipliedBy(0.4)
        }
        
        genderDetailIntroduction.snp.makeConstraints { make in
            make.leadingMargin.equalTo(30)
            make.trailingMargin.equalTo(-30)
            make.height.equalTo(50)
            make.bottom.equalTo(maleButton.snp.top).offset(-20)
        }
        
        maleButton.snp.makeConstraints { make in
            make.leadingMargin.equalTo(20)
            make.bottom.equalTo(genderPassButton.snp.top).offset(-30)
            make.width.equalTo(self).multipliedBy(0.4)
            make.height.equalTo(100)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.trailingMargin.equalTo(-20)
            make.bottom.equalTo(genderPassButton.snp.top).offset(-30)
            make.width.equalTo(self).multipliedBy(0.4)
            make.height.equalTo(100)
        }
        
        genderPassButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}

