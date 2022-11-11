//
//  ThirdOnboardingView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import Foundation
import UIKit

class ThirdOnboardingView: BaseView {
    let serviceIntroduction: OnboardingLabel = {
        let view = OnboardingLabel()
        view.text = "SeSAC Study"
        return view
    }()
    
    let onboardingImg3: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "onboarding_img3")
        return view
    }()
    
    override func configure() {
        [serviceIntroduction, onboardingImg3].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        serviceIntroduction.snp.makeConstraints { make in
            make.leadingMargin.equalTo(60)
            make.trailingMargin.equalTo(-60)
            make.height.equalTo(100)
            make.bottom.equalTo(onboardingImg3.snp.top).offset(-50)
        }
        
        onboardingImg3.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(0)
            make.width.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.6)
        }
    }
}
