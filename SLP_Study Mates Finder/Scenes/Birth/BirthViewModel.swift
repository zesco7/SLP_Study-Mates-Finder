//
//  BirthViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift

class BirthViewModel: CommonProperties {
    var baseView = BaseView()
    
    var birthDateEvent = PublishRelay<Bool>()
    var birthYearEvent = PublishRelay<String>()
    var birthMonthEvent = PublishRelay<String>()
    var birthDayEvent = PublishRelay<String>()
    
    var isValidBirthDate: Bool = false
    var birthDate: Date = Date()
    var birthYear: String = ""
    var birthMonth: String = ""
    var birthDay: String = ""
    
    let yearArray : [Int] = Array(1922...2022).reversed()
    let monthArray = Array(1...12)
    let dayArray = Array(1...31)
    
    var signUpData: SignUpData = SignUpData()
    
    func birthValidation(birth: Date) {
        birthDate = birth
        let dateDifference =
        Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: Date())
        
        if dateDifference.year! >= 17 && dateDifference.month! <= 12 && dateDifference.day! <= 31 {
            isValidBirthDate = true
            birthDateEvent.accept(isValidBirthDate)
        } else {
            isValidBirthDate = false
            birthDateEvent.accept(isValidBirthDate)
        }
        let birthData = birthDate.ISO8601Format()
        signUpData.birth = birthData
    }
    
    func dateFormatter(datePicker: UIDatePicker) {
        let dateComponents = datePicker.calendar.dateComponents([.year, .month, .day], from: datePicker.date)
        birthYear = String(describing: dateComponents.year!)
        birthMonth = String(describing: dateComponents.month!)
        birthDay = String(describing: dateComponents.day!)
        
        birthYearEvent.accept(birthYear)
        birthMonthEvent.accept(birthMonth)
        birthDayEvent.accept(birthDay)
    }
}
