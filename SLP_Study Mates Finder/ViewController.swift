//
//  ViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/09.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    var phoneNumber = "+82 01012345678"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().languageCode = "kr";
        
        PhoneAuthProvider.provider()
          .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
              if let error = error {
                print(error)
                return
              }
              print("verify phone")
              UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
          }
    }


}

