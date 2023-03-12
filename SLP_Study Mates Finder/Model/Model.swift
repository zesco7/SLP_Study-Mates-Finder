//
//  Model.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/05.
//

import Foundation

struct PhoneNumberModel {
    var phoneNum: String
}

struct SignUpData {
    var nickName: String
    var birth: Date
    var email: String
    var gender: Int
}

struct BirthDate {
    var year: Int
    var month: Int
    var day: Int
}
