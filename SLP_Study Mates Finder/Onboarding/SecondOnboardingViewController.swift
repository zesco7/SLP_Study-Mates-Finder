//
//  SecondOnboardingViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit

class SecondOnboardingViewController: BaseViewController {
    var mainView = SecondOnboardingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
