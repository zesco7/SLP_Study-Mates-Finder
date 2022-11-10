//
//  MainOnboardingView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import Foundation
import UIKit

class MainOnboardingView: BaseView {
    let containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let startButton: UIButton = {
        let view = UIButton()
        view.setTitle("시작하기", for: .normal)
        view.backgroundColor = .green
        view.layer.cornerRadius = 5
        return view
    }()
    
    override func configure() {
        [containerView, startButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(containerView.snp.bottom).offset(60)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}
