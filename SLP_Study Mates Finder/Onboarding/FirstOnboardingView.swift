//
//  OnboardingView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import Foundation
import UIKit

class FirstOnboardingView: BaseView {
    let serviceIntroduction: UILabel = {
        let view = UILabel()
        view.text = "위치 기반으로 빠르게 주위 친구를 확인"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 25)
        view.textColor = .black
        
        let attributtedString = NSMutableAttributedString(string: view.text!)
        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: (view.text! as NSString).range(of:"위치"))
        attributtedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: (view.text! as NSString).range(of:"기반"))
        view.attributedText = attributtedString
        return view
    }()
    
    let onboardingImg1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onboarding_img1")
        return view
    }()

    override func configure() {
        [serviceIntroduction, onboardingImg1].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        serviceIntroduction.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(100)
            make.bottom.equalTo(onboardingImg1.snp.top).offset(-50)
        }
        
        onboardingImg1.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(0)
            make.width.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.6)
        }
    }
}
