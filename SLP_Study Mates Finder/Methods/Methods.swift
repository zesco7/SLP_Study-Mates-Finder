//
//  Methods.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/15.
//

import UIKit

class Methods {
    static func moveToHome() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate =  windowScene?.delegate as? SceneDelegate
        let vc = ViewController()
        let navi = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = navi
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    static func moveToSignUp() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate =  windowScene?.delegate as? SceneDelegate
        let view = PhoneNumberView()
        let vc = PhoneNumberViewController(mainView: view)
        let navi = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = navi
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
