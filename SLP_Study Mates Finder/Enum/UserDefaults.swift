//
//  UserDefaults.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/20.
//

import Foundation

enum SignUpUserDefaults: String {
    case FCMToken = "FCMToken"
    case idToken = "idToken"
    
    var userDefaults: String {
        switch self {
        case .FCMToken:
            return UserDefaults.standard.string(forKey: "FCMToken")!
        case .idToken:
            return UserDefaults.standard.string(forKey: "idToken")!
        default:
            return ""
        }
    }
}
