//
//  CertificationNumberCheckViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit
import RxSwift

class CertificationNumberCheckViewController: BaseViewController {
    var mainView = CertificationNumberCheck()
    let border = CALayer()
    let viewModel = CertificationNumberCheckViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.certificationStartButton.addTarget(self, action: #selector(certificationStartButtonClicked), for: .touchUpInside)
        viewModel.checkValidation(code: mainView.certificationNumberCheckTextField.text!)
    }
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.certificationNumberCheckTextField.frame.size.height-1, width: mainView.certificationNumberCheckTextField.frame.width, height: 1)
        border.gray3()
        mainView.certificationNumberCheckTextField.layer.addSublayer((border))
    }
    
    @objc func certificationStartButtonClicked() {
        let vc = NicknameViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
