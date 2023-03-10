//
//  Enum.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/09.
//

import Foundation

enum SignUpMessages: String {
    case phoneNumber
    case certification
    case nickname
    case birth
    case email
    case gender

    var messages: String {
        switch self {
        case .phoneNumber:
            return "새싹 서비스 이용을 위해 휴대폰 번호를 입력해 주세요"
        case .certification:
            return "인증 번호가 문자로 전송되었어요"
        case .nickname:
            return "닉네임을 입력해주세요"
        case .birth:
            return "생년월일을 알려주세요"
        case .email:
            return "이메일을 입력해주세요"
        case .gender:
            return "성별을 선택해주세요"
        default:
            return ""
        }
    }
}

enum SignUpPageTypes {
    case plain
    case auth
    case password
}

//struct UIContext {
//    var textFieldType: type
//    var placeholder: String
//    var keyboardType: //키보드 타입
//}
