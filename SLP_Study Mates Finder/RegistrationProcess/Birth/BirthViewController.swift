//
//  BirthViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit
import RxSwift
import Toast

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
        mainView.birthYearTextField.becomeFirstResponder()
        pickerViewRegistration()
        birthAddTargetCollection()
        birthPassButtonColorChange()
        
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
    
    func birthPassButtonColorChange() {
        mainView.birthDayTextField.rx.text
            .map { $0!.isEmpty }
            .withUnretained(self)
            .bind { (vc, value) in
                value ? self.mainView.birthPassButton.gray6() :  self.mainView.birthPassButton.green()
            }
            .disposed(by: disposeBag)
    }
    
    func birthValidation() {
        let birthYearIsEmpty = mainView.birthYearTextField.text?.isEmpty
        let birthMonthIsEmpty = mainView.birthMonthTextField.text?.isEmpty
        let birthDayIsEmpty = mainView.birthDayTextField.text?.isEmpty
        
        if birthYearIsEmpty == false && birthMonthIsEmpty == false && birthDayIsEmpty == false {
            ageCheck()
            print("All False")
        } else {
            mainView.birthPassButton.gray6()
            print("Not All False")
        }
    }
    
    func ageCheck() {
        let timeZone = TimeZone(abbreviation: "KST")
        let year = Int(mainView.birthYearTextField.text!)
        let month = Int(mainView.birthMonthTextField.text!)
        let day = Int(mainView.birthDayTextField.text!)
        
        let birthString = "\(year!)-\(month!)-\(day!)T12:34:56.789Z"
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let savedBirthDate = dateformatter.date(from: birthString)
        //Q. 날짜데이터 ud에 저장안되는 이유?
        UserDefaults.standard.set(savedBirthDate, forKey: "birth")
        print(UserDefaults.standard.string(forKey: "birth"))
        
        let standard = DateComponents(timeZone: timeZone, year: year, month: month, day: day)
        let birthDate = Calendar.current.date(from: standard)!
        let dateDifference = Calendar.current.dateComponents([.year, .month, .day], from: birthDate, to: Date())
        
        if dateDifference.year! > 17 {
            print("가입 가능: 만 17세 이상")
            let vc = EmailViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if dateDifference.year! == 17 {
            if dateDifference.month! <= 0 && dateDifference.day! <= 0 {
                print("가입 가능: 만 17세 이상")
                let vc = EmailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.view.makeToast("새싹스터디는 만 17세 이상만 사용할 수 있습니다.", duration: 1, position: .top)
                print("가입 불가: 만 17세 미만")
            }
        } else if dateDifference.year! < 17 {
            self.view.makeToast("새싹스터디는 만 17세 이상만 사용할 수 있습니다.", duration: 1, position: .top)
            print("가입 불가: 만 17세 미만")
        }
    }
    
    @objc func birthPassButtonClicked() {
        birthValidation()
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
