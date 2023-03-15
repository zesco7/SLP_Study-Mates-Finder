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
    
    var subMessages: String {
        switch self {
        case .email:
            return "휴대폰 번호 변경 시 인증을 위해 사용해요"
        case .gender:
            return "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        default:
            return ""
        }
    }
}

enum ButtonMessages: String {
    case phoneNumber
    case certification
    case restPages

    var messages: String {
        switch self {
        case .phoneNumber:
            return "인증 문자 받기"
        case .certification:
            return "인증하고 시작하기"
        case .restPages:
            return "다음"
        default:
            return ""
        }
    }
    
    var subButtonMessages: String {
        switch self {
        case .certification:
            return "재전송"
        default:
            return ""
        }
    }
}

enum Placeholder: String {
    case phoneNumber
    case certification
    case nickname

    var messages: String {
        switch self {
        case .phoneNumber:
            return "휴대폰 번호(-없이 숫자만 입력)"
        case .certification:
            return "인증번호 입력"
        case .nickname:
            return "10자 이내로 입력"
        default:
            return ""
        }
    }
}

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
            return "닉네임은 1자 이상 10자 이내로 부탁드려요."
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

enum SignUpUserDefaults: String {
    case authVerificationID = "authVerificationID"
    case FCMToken = "FCMToken"
    case idToken = "idToken"
    case phoneNumber = "phoneNumber"
    case certification = "certification"
    case nickname = "nickname"
    case birth = "birth"
    case email = "email"
    case gender = "gender"
    
    var userDefaults: String {
        switch self {
        case .authVerificationID:
            return UserDefaults.standard.string(forKey: "authVerificationID")!
        case .FCMToken:
            return UserDefaults.standard.string(forKey: "FCMToken")!
        case .idToken:
            return UserDefaults.standard.string(forKey: "idToken")!
        case .phoneNumber:
            return UserDefaults.standard.string(forKey: "phoneNumber")!
        case .certification:
            return UserDefaults.standard.string(forKey: "certification")!
        case .nickname:
            return UserDefaults.standard.string(forKey: "nickname")!
        case .birth:
            return UserDefaults.standard.string(forKey: "birth")!
        case .email:
            return UserDefaults.standard.string(forKey: "email")!
        case .gender:
            return UserDefaults.standard.string(forKey: "gender")!
        default:
            return ""
        }
    }
}
