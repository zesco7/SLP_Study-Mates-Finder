//
//  BirthViewModel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import RxCocoa
import RxSwift

class BirthViewModel {
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
    
    func birthValidation(birth: Date) {
        birthDate = birth
        let dateDifference =
        Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: Date())
        
        //강제 언래핑해야하는지?
        if dateDifference.year! >= 17 && dateDifference.month! <= 12 && dateDifference.day! <= 31 {
            isValidBirthDate = true
            birthDateEvent.accept(isValidBirthDate)
        } else {
            isValidBirthDate = false
            birthDateEvent.accept(isValidBirthDate)
        }
        let birthData = birthDate.ISO8601Format()
        UserDefaults.standard.set(birthData, forKey: SignUpUserDefaults.birth.rawValue)
    }
    
    func dateFormatter(datePicker: UIDatePicker) {
        //피커 클릭해서 데이터 받는것과 화면에 표시하는걸 구분해야하는지?
        let dateComponents = datePicker.calendar.dateComponents([.year, .month, .day], from: datePicker.date)
        //dateComponents 반환 타입이 Int?이므로 언래핑 해줘야함.
        //강제 언래핑해야하는지?
        birthYear = String(describing: dateComponents.year!)
        birthMonth = String(describing: dateComponents.month!)
        birthDay = String(describing: dateComponents.day!)
        
        birthYearEvent.accept(birthYear)
        birthMonthEvent.accept(birthMonth)
        birthDayEvent.accept(birthDay)
    }
    
    //mvp
    func dateFormatter2(mainView: BirthView) {
        //피커 클릭해서 데이터 받는것과 화면에 표시하는걸 구분해야하는지?
        birthDate = mainView.birthDatePicker.date
        let formattedDate = birthDate.ISO8601Format()
        let dateComponents = mainView.birthDatePicker.calendar.dateComponents([.year, .month, .day], from: birthDate)
        mainView.birthYearTextField.text = "\(dateComponents.year!)"
        mainView.birthMonthTextField.text = "\(dateComponents.month!)"
        mainView.birthDayTextField.text = "\(dateComponents.day!)"
    }
}
