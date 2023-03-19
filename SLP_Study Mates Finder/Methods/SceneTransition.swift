//
//  Methods.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/15.
//

import UIKit

class SceneTransition {
    static func moveToHome(_ viewController: UIViewController) {
        let vc = ViewController()
        viewController.present(vc, animated: true)
    }
    
    static func moveToPhoneNumber(_ viewController: UIViewController) {
        let vc = PhoneNumberViewController(mainView: PhoneNumberView())
        vc.modalPresentationStyle = .fullScreen
        viewController.present(vc, animated: true)
    }
    
    static func moveToNickname(_ viewController: UIViewController, signUpData: SignUpData) {
//        let vc = NicknameViewController(mainView: NicknameView(), signUpData: signUpData)
//        vc.modalPresentationStyle = .fullScreen
//        viewController.present(vc, animated: true)
        
        let vc = NicknameViewController(mainView: NicknameView(), signUpData: signUpData)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
