//
//  UserDefaultsHelper.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/15.
//

import Foundation

struct UserDefaultsHelper {
    var authVerificationID = SignUpUserDefaults.authVerificationID.userDefaults
    var FCMToken = SignUpUserDefaults.FCMToken.userDefaults
    var idToken = SignUpUserDefaults.idToken.userDefaults
    var phoneNumber = SignUpUserDefaults.phoneNumber.userDefaults
    var certification = SignUpUserDefaults.certification.userDefaults
    var nickName = SignUpUserDefaults.nickname.userDefaults
    var birth = SignUpUserDefaults.birth.userDefaults
    var email = SignUpUserDefaults.email.userDefaults
    var gender = SignUpUserDefaults.gender.userDefaults
}
