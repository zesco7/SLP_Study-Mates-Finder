//
//  CertificationView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/11.
//

import UIKit
import SnapKit

class CertificationView: BaseView {
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
    
    let certificationLabel: RegistrationProcessLabel = {
       let view = RegistrationProcessLabel()
        view.text = SignUpMessages.certification.messages
        return view
    }()
    
    let certificationTextField: UITextField = {
       let view = UITextField()
        view.placeholder = Placeholder.certification.messages
        view.keyboardType = .decimalPad
        view.textColor = .black
        view.borderStyle = .none

        return view
    }()
    
    let retryButton: LargeButton = {
        let view = LargeButton()
        view.setTitle(ButtonMessages.certification.subButtonMessages, for: .normal)
        view.green()
        return view
    }()
    
    let certificationButton: LargeButton = {
        let view = LargeButton()
        view.setTitle(ButtonMessages.certification.messages, for: .normal)
        return view
    }()
    
    override func configure() {
        [certificationLabel, certificationTextField, retryButton, certificationButton].forEach {
            self.addSubview($0)
        }
    }
    
    func textFieldBorderAttribute() {
        border.frame = CGRect(x: 0, y: self.certificationTextField.frame.size.height-1, width: self.certificationTextField.frame.width, height: 1)
        border.gray3()
        self.certificationTextField.layer.addSublayer((border))
    }
    
    override func setConstraints() {
        certificationLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(30)
            make.trailingMargin.equalTo(-30)
            make.height.equalTo(50)
            make.centerY.equalTo(self).multipliedBy(0.4)
        }
        
        certificationTextField.snp.makeConstraints { make in
            make.bottom.equalTo(certificationButton.snp.top).offset(-60)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-120)
            make.height.equalTo(50)
        }
        
        retryButton.snp.makeConstraints { make in
            make.bottom.equalTo(certificationButton.snp.top).offset(-60)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        certificationButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}
