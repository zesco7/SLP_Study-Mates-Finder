//
//  Toast.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/20.
//

import Foundation

enum SignUpToastMessages: String {
    case phoneNumber
    case certification
    case nickname
    case birth
    case email
    case gender

    var messages: String {
        switch self {
        case .phoneNumber:
            return "올바른 전화번호 형식이 아닙니다."
        case .certification:
            return "올바른 인증번호 형식이 아닙니다."
        case .nickname:
            return "닉네임은 2~10글자만 가능합니다.(특수문자 불가)"
        case .birth:
            return "새싹스터디는 만 17세 이상만 사용할 수 있습니다."
        case .email:
            return "이메일 형식이 올바르지 않습니다."
        case .gender:
            return "성별을 선택하지 않았습니다."
        }
    }
}

enum FirebaseToastMessages: String {
    case failureVerified
    case errorExceptFailure

    var messages: String {
        switch self {
        case .failureVerified:
            return "전화번호 인증 실패(인증번호 기간이 만료 또는 부정확한 인증번호)"
        case .errorExceptFailure:
            return "에러가 발생했습니다. 잠시 후 다시 시도해주세요."
        default:
            return ""
        }
    }
}




