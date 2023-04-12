//
//  LoginSelectionView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/04/12.
//

import UIKit
import SnapKit

class LoginSelectionView: BaseView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var signUpMessage: UILabel = {
        let view = UILabel()
        view.text = "회원가입"
        view.font = .systemFont(ofSize: 25, weight: .bold)
        view.textColor = .black
        return view
    }()
    
    var signUpSubMessage: UILabel = {
        let view = UILabel()
        view.text = "편리한 서비스, 스터디 메이트를 지금 시작해보세요."
        view.font = .systemFont(ofSize: 14)
        view.textColor = .gray
        return view
    }()
    
    var signUpButton: UIButton = {
        let view = UIButton()
        view.setTitle("스터디 메이트 계정 직접 만들기", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.textAlignment = .center
        view.green()
        return view
    }()
    
    var divisionLine: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    var loginMessage: UILabel = {
        let view = UILabel()
        view.text = "또는 소셜 로그인 하기"
        view.font = .systemFont(ofSize: 10)
        view.textAlignment = .center
        view.textColor = .systemGray
        return view
    }()
    
    var googleLoginButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "google_logo"), for: .normal)
        view.layer.backgroundColor = .none
        return view
    }()
    
    var appleLoginButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "apple_logo"), for: .normal)
        view.layer.backgroundColor = .none
        return view
    }()
    
    var kakaoLoginButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "kakaotalk_logo"), for: .normal)
        view.layer.backgroundColor = .none
        return view
    }()
    
    var naverLoginButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "naver_logo"), for: .normal)
        view.layer.backgroundColor = .none
        return view
    }()
    
    override func configure() {
        [signUpMessage, signUpSubMessage, signUpButton, divisionLine, loginMessage, googleLoginButton, appleLoginButton, kakaoLoginButton, naverLoginButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        signUpMessage.snp.makeConstraints { make in
            make.topMargin.equalTo(30)
            make.width.lessThanOrEqualTo(120)
            make.height.equalTo(40)
            make.leadingMargin.equalTo(0)
        }
        
        signUpSubMessage.snp.makeConstraints { make in
            make.topMargin.equalTo(signUpMessage).offset(40)
            make.width.equalTo(self)
            make.height.equalTo(30)
            make.leadingMargin.equalTo(0)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.topMargin.equalTo(signUpSubMessage).offset(40)
            make.height.equalTo(40)
            make.leadingMargin.equalTo(0)
            make.trailingMargin.equalTo(0)
        }
        
        divisionLine.snp.makeConstraints { make in
            make.topMargin.equalTo(signUpButton).offset(80)
            make.height.equalTo(1)
            make.leadingMargin.equalTo(0)
            make.trailingMargin.equalTo(0)
        }
        
        loginMessage.snp.makeConstraints { make in
            make.topMargin.equalTo(divisionLine).offset(0)
            make.width.equalTo(self)
            make.height.equalTo(20)
            make.centerX.equalTo(self)
        }
        
        googleLoginButton.snp.makeConstraints { make in
            make.centerY.equalTo(self).multipliedBy(0.75)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerX.equalTo(self).multipliedBy(0.35)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.centerY.equalTo(self).multipliedBy(0.75)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.leadingMargin.equalTo(googleLoginButton).offset(90)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.centerY.equalTo(self).multipliedBy(0.75)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.leadingMargin.equalTo(appleLoginButton).offset(90)
        }
        
        naverLoginButton.snp.makeConstraints { make in
            make.centerY.equalTo(self).multipliedBy(0.75)
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.leadingMargin.equalTo(kakaoLoginButton).offset(80)
        }
    }
}
