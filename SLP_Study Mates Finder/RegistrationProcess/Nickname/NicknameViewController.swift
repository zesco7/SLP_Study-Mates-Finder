//
//  NicknameViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

class NicknameViewController: BaseViewController {
    var mainView = NicknameView()
    let border = CALayer()
    let viewModel = NicknameViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.nicknameTextField.becomeFirstResponder()
        nicknameAddTargetCollection()
        nicknameCountValidation()
        }
    
    func nicknameAddTargetCollection() {
        mainView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingDidBegin), for: .editingDidBegin)
        mainView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldEditingDidEnd), for: .editingDidEnd)
        mainView.nicknamePassButton.addTarget(self, action: #selector(nicknamePassButtonClicked), for: .touchUpInside)
    }
    
    func nicknameCountValidation() {
        mainView.nicknameTextField.rx.text.orEmpty
            .map { $0.count >= 1 && $0.count <= 10}
            .withUnretained(self)
            .bind { (vc, value) in
                value ? self.mainView.nicknamePassButton.green() : self.mainView.nicknamePassButton.gray6()
            }
            .disposed(by: disposeBag)
    }
    
    @objc func nicknameTextFieldEditingDidBegin() {
        border.black()
        mainView.nicknameTextField.layer.addSublayer((border))
    }
    
    @objc func nicknameTextFieldEditingDidEnd() {
        border.gray3()
        mainView.nicknameTextField.layer.addSublayer((border))
    }
    
    @objc func nicknamePassButtonClicked() {
        if mainView.nicknameTextField.text?.count == 0 || mainView.nicknameTextField.text!.count > 10 {
            self.view.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요.", duration: 1.0, position: .top)
        } else {
            UserDefaults.standard.set(mainView.nicknameTextField.text, forKey: "nickname")
            let vc = BirthViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.nicknameTextField.frame.size.height-1, width: mainView.nicknameTextField.frame.width, height: 1)
        border.gray3()
        mainView.nicknameTextField.layer.addSublayer((border))
    }
}
