//
//  NicknameView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import Foundation
import UIKit

class NicknameView: BaseView {
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
    
    let nicknameLabel: SignUpLabel = {
       let view = SignUpLabel()
        view.text = SignUpMessages.nickname.messages
        return view
    }()
    
    let nicknameTextField: UITextField = {
       let view = UITextField()
        view.placeholder = Placeholder.nickname.messages
        view.textColor = .black
        view.borderStyle = .none

        return view
    }()
    
    let nicknameButton: LargeButton = {
        let view = LargeButton()
        view.setTitle(ButtonMessages.restPages.messages, for: .normal)
        return view
    }()
    
    override func configure() {
        [nicknameLabel, nicknameTextField, nicknameButton].forEach {
            self.addSubview($0)
        }
    }
    
    func textFieldBorderAttribute() {
        border.frame = CGRect(x: 0, y: self.nicknameTextField.frame.size.height-1, width: self.nicknameTextField.frame.width, height: 1)
        border.gray3()
        self.nicknameTextField.layer.addSublayer((border))
    }
    
    override func setConstraints() {
        nicknameLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(50)
            make.centerY.equalTo(self).multipliedBy(0.4)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(nicknameButton.snp.top).offset(-60)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
        
        nicknameButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}
