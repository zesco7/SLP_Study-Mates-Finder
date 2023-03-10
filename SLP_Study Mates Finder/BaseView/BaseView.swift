//
//  BaseView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit
import SnapKit

class BaseView: UIView {
    let border = CALayer()
    
    var label: RegistrationProcessLabel = {
        let view = RegistrationProcessLabel()
        view.text = SignUpMessages.phoneNumber.messages
        return view
    }()

    var view: UIControl = {
        let view = CustomTextField().phoneNumberTextField
        return view
    }()
    
    var button: LargeButton = {
        let view = LargeButton()
        view.setTitle("인증 문자 받기", for: .normal)
        return view
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        configure()
        setConstraints()
        activeTextFieldBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        [label, view, button].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        label.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(50)
            make.centerY.equalTo(self).multipliedBy(0.4)
        }
        
        view.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(button.snp.top).offset(-60)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }

    func textFieldBorderAttribute() {
        border.frame = CGRect(x: 0, y: self.view.frame.size.height-1, width: self.view.frame.width, height: 1)
        border.gray3()
        self.view.layer.addSublayer((border))
    }
    
    func activeTextFieldBorder() {
        self.view.addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        self.view.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        self.view.addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
    }

    @objc func textFieldEditingDidBegin() {
        border.black()
        self.view.layer.addSublayer((border))
    }
    
    @objc func textFieldEditingChanged() {
        border.black()
        self.view.layer.addSublayer((border))
    }

    @objc func textFieldEditingDidEnd() {
        border.gray3()
        self.view.layer.addSublayer((border))
    }
}
