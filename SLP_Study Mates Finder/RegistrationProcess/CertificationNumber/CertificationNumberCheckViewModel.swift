//
//  CertificationNumberCheckViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/12.
//

import Foundation

class CertificationNumberCheckViewModel {
    var certificationCode: Observable<String>?
    var isValid: Observable<Bool> = Observable(false) //반응형으로 타입설정
    
    func checkValidation(code: String) {
        if code.count >= 6 {
            isValid.value = true
        } else {
            isValid.value = false
        }
    }
    
}
