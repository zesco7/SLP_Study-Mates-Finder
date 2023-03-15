//
//  EmailView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import Foundation
import UIKit

class EmailView: BaseView {
    let border = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
        textFieldBorderAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let emailLabel: SignUpLabel = {
       let view = SignUpLabel()
        view.text = SignUpMessages.email.messages
        return view
    }()
    
    let emailSubLabel: SignUpSubLabel = {
       let view = SignUpSubLabel()
        view.text = SignUpMessages.email.subMessages
        return view
    }()
    
    let emailTextField: UITextField = {
       let view = UITextField()
        view.textColor = .black
        view.borderStyle = .none

        return view
    }()
    
    let emailButton: LargeButton = {
        let view = LargeButton()
        view.setTitle(ButtonMessages.restPages.messages, for: .normal)
        return view
    }()
    
    override func configure() {
        [emailLabel, emailSubLabel, emailTextField, emailButton].forEach {
            self.addSubview($0)
        }
    }
    
    func textFieldBorderAttribute() {
        border.frame = CGRect(x: 0, y: self.emailTextField.frame.size.height-1, width: self.emailTextField.frame.width, height: 1)
        border.gray3()
        self.emailTextField.layer.addSublayer((border))
    }
    
    override func setConstraints() {
        emailLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(50)
            make.centerY.equalTo(self).multipliedBy(0.4)
        }
        
        emailSubLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(30)
            make.trailingMargin.equalTo(-30)
            make.height.equalTo(50)
            make.bottom.equalTo(emailTextField.snp.top).offset(-30)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(emailButton.snp.top).offset(-60)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        emailButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}

