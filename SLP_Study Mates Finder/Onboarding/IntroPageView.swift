//
//  IntroPageView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import Foundation
import UIKit

class IntroPageView: BaseView {
    let navigationView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var vc1: FirstOnboardingViewController = {
        let vc = FirstOnboardingViewController()
        return vc
    }()
    
    lazy var vc2: SecondOnboardingViewController = {
        let vc = SecondOnboardingViewController()
        return vc
    }()
    
    lazy var vc3: ThirdOnboardingViewController = {
        let vc = ThirdOnboardingViewController()
        return vc
    }()
    
    lazy var dataViewControllers: [UIViewController] = {
        return [vc1, vc2, vc3]
    }()
    
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return vc
    }()
    
    let startButton: UIButton = {
        let view = UIButton()
        view.setTitle("시작하기", for: .normal)
        view.backgroundColor = .green
        view.layer.cornerRadius = 5
        return view
    }()
    
    override func configure() {
        [navigationView, pageViewController.view, startButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        navigationView.snp.makeConstraints { make in
            make.width.height.equalTo(self)
            make.centerX.centerY.equalTo(self)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(0)
            make.width.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.8)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(pageViewController.view.snp.bottom).offset(60)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}

