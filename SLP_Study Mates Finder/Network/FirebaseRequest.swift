//
//  FirebaseRequest.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/14.
//

import UIKit
import Firebase
import FirebaseAuth
import RxSwift

class FirebaseRequest {
    static func requestVerificationCode(phoneNumber: String) -> Observable<String> {
        return .create { observer -> Disposable in
            Auth.auth().languageCode = "kr"
            PhoneAuthProvider.provider()
                .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                    if let error = error {
                        observer.onError(error)
                    }
                    
                    guard let verificationID = verificationID else {
                        UserDefaults.standard.set(verificationID, forKey: SignUpUserDefaults.authVerificationID.rawValue)
//                        observer.onError(<#T##error: Error##Error#>)
                        return
                    }
                    observer.onNext(verificationID)
                }
            return Disposables.create()
        }
//        Auth.auth().languageCode = "kr";
//        PhoneAuthProvider.provider()
//            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
//                if let error = error {
//                    print(error)
//                    return
//                }
//
//                UserDefaults.standard.set(verificationID, forKey: SignUpUserDefaults.authVerificationID.rawValue)
//                print("verify phone", verificationID!)
//            }
    }
}
