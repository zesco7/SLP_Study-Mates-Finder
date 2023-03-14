//
//  FirebaseRequest.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/14.
//

import UIKit
import Firebase
import FirebaseAuth

class FirebaseRequest {
    static func requestVerificationCode(phoneNumber: String) {
        Auth.auth().languageCode = "kr";
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error)
                    return
                }
                UserDefaults.standard.set(verificationID, forKey: SignUpUserDefaults.authVerificationID.rawValue)
                print("verify phone", verificationID!)
            }
    }
}
