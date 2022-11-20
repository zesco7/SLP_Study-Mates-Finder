//
//  GenderViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit

class GenderViewController: BaseViewController {
    var mainView = GenderView()
    let border = CALayer()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.maleButton.addTarget(self, action: #selector(maleButtonClicked), for: .touchDown)
        mainView.femaleButton.addTarget(self, action: #selector(femaleButtonClicked), for: .touchDown)
        mainView.genderPassButton.addTarget(self, action: #selector(genderPassButtonClicked), for: .touchUpInside)
      
    }
    
    @objc func maleButtonClicked() {
        if mainView.maleButton.backgroundColor == .white {
            mainView.maleButton.whiteGreen()
            mainView.maleButton.layer.borderColor = .none
        } else {
            mainView.maleButton.backgroundColor = .white
        }
    }
    
    @objc func femaleButtonClicked() {
        if mainView.femaleButton.backgroundColor == .white {
            mainView.femaleButton.whiteGreen()
            mainView.femaleButton.layer.borderColor = .none
        } else {
            mainView.femaleButton.backgroundColor = .white
        }
    }
    
    @objc func genderPassButtonClicked() {
        let vc = BirthViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
