//
//  ViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/09.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    var message: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 18)
        view.backgroundColor = .systemGray4
        view.text = "로그인 후 다른 기능은 없으며, 회원가입 부분만 포트폴리오에 해당합니다."
        return view
    }()
    
    var logoButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "sesac_face"), for: .normal)
        return view
    }()
    
    var subMessage: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13)
        view.text = "*그림을 누르면 회원가입 화면으로 이동합니다."
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configure()
        setContraints()
        moveToPhoneNumber()
    }
    
    func moveToPhoneNumber() {
        logoButton.addTarget(self, action: #selector(serviceLogoButtonTapped), for: .touchUpInside)
    }
    
    @objc func serviceLogoButtonTapped() {
        Methods.moveToPhoneNumber()
    }
    
    func configure() {
        [message, logoButton, subMessage].forEach {
            self.view.addSubview($0)
        }
    }
    
    func setContraints() {
        message.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(self.view).multipliedBy(0.8)
            make.height.equalTo(80)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.4)
        }
        
        logoButton.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(250)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view)
        }

        subMessage.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(self.view).multipliedBy(0.8)
            make.height.equalTo(40)
            make.centerX.equalTo(self.view)
            make.topMargin.equalTo(logoButton.snp.bottom).offset(20)
        }
    }
}

