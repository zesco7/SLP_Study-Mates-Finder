//
//  BirthViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit
import RxSwift

class BirthViewController: BaseViewController {
    var mainView = BirthView()
    
    let border = CALayer()
    let border2 = CALayer()
    let border3 = CALayer()
    
    let pickerView = UIPickerView()
    
    let yearArray : [Int] = Array(1922...2022).reversed()
    let monthArray = Array(1...12)
    let dayArray = Array(1...31)
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerViewRegistration()
        birthAddTargetCollection()
        birthValidation()
        ageCheck()
    }
    
    func pickerViewRegistration() {
        mainView.birthYearTextField.inputView = pickerView
        mainView.birthMonthTextField.inputView = pickerView
        mainView.birthDayTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func birthAddTargetCollection() {
        mainView.birthPassButton.addTarget(self, action: #selector(birthPassButtonClicked), for: .touchUpInside)
    }
    
    func birthValidation() {
        mainView.birthYearTextField.rx.text
            .map { $0!.count >= 1 }
            .withUnretained(self)
            .bind { (vc, value) in
                return value
            }
            .disposed(by: disposeBag)

        
//        mainView.birthMonthTextField.rx.text
//            .withUnretained(self)
//            .bind { (vc, _) in
//                self.mainView.birthPassButton.green()
//            }
//            .disposed(by: disposeBag)
//
//        mainView.birthDayTextField.rx.text
//            .withUnretained(self)
//            .bind { (vc, _) in
//                self.mainView.birthPassButton.green()
//            }
//            .disposed(by: disposeBag)
    }
    
    func ageCheck() {
        let date = Date()
        let todayYear = Calendar.current.dateComponents([.year], from: date)
        let todayMonth = Calendar.current.dateComponents([.month], from: date)
        let todayDay = Calendar.current.dateComponents([.day], from: date)
        let timeZone = TimeZone(abbreviation: "KST")
        let dateComponents = DateComponents(timeZone: timeZone, year: todayYear.year, month: todayMonth.month, day: todayDay.day)
        let date2 = Calendar.current.date(from: dateComponents)!
        print(date2)
        print(Date(timeInterval: 20, since: date2))
        //현재시간-생년월일 입력시간 >= 17
    }
    
    @objc func birthPassButtonClicked() {
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        border.frame = CGRect(x: 0, y: mainView.birthYearTextField.frame.size.height-1, width: mainView.birthYearTextField.frame.width, height: 1)
        border2.frame = CGRect(x: 0, y: mainView.birthMonthTextField.frame.size.height-1, width: mainView.birthMonthTextField.frame.width, height: 1)
        border3.frame = CGRect(x: 0, y: mainView.birthDayTextField.frame.size.height-1, width: mainView.birthDayTextField.frame.width, height: 1)
        border.gray3()
        border2.gray3()
        border3.gray3()
        mainView.birthYearTextField.layer.addSublayer((border))
        mainView.birthMonthTextField.layer.addSublayer((border2))
        mainView.birthDayTextField.layer.addSublayer((border3))
        }
}

extension BirthViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return yearArray.count
        case 1:
            return monthArray.count
        case 2:
            return dayArray.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(yearArray[row])년"
        case 1:
            return "\(monthArray[row])월"
        case 2:
            return "\(dayArray[row])일"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            mainView.birthYearTextField.text = "\(yearArray[row])"
        case 1:
            mainView.birthMonthTextField.text = "\(monthArray[row])"
        case 2:
            mainView.birthDayTextField.text = "\(dayArray[row])"
        default:
            ""
        }
    }
}
