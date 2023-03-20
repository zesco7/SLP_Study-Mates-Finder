//
//  BirthViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

class BirthViewController: UIViewController {
    var mainView: BirthView
    let viewModel = BirthViewModel()
    let disposeBag = DisposeBag()
    let pickerView = UIDatePicker()

    init(mainView: BirthView, signUpData: SignUpData) {
        self.mainView = mainView
        self.viewModel.signUpData = signUpData
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        bind()
        pickerViewAttribute()
        activateAction()
    }
    
    func bind() {
        viewModel.birthYearEvent.asDriver(onErrorJustReturn: "")
            .drive(onNext: { yearData in
                self.mainView.birthYearTextField.text = yearData
            })
            .disposed(by: disposeBag)
        
        viewModel.birthMonthEvent.asDriver(onErrorJustReturn: "")
            .drive(onNext: { monthData in
                self.mainView.birthMonthTextField.text = monthData
            })
            .disposed(by: disposeBag)
        
        viewModel.birthDayEvent.asDriver(onErrorJustReturn: "")
            .drive(onNext: { dayData in
                self.mainView.birthDayTextField.text = dayData
            })
            .disposed(by: disposeBag)
        
        viewModel.birthDateEvent.asDriver(onErrorJustReturn: false)
            .drive { isValid in
                if isValid {
                    self.mainView.birthButton.green()
                } else {
                    self.mainView.birthButton.gray6()
                }
            }
    }
    
    func pickerViewAttribute() {
        pickerView.datePickerMode = .date
    }
    
    func activateAction() {
        mainView.birthDatePicker.addTarget(self, action: #selector(birthDatePickerSelected), for: .valueChanged)
        mainView.birthButton.addTarget(self, action: #selector(birthButtonTapped), for: .touchUpInside)
    }
    
    @objc func birthDatePickerSelected() {
        let date = mainView.birthDatePicker.date
        viewModel.birthValidation(birth: date)
        viewModel.dateFormatter(datePicker: mainView.birthDatePicker)
    }
    
    @objc func birthButtonTapped() {
        if viewModel.isValidBirthDate {
            pushScene()
        } else {
            self.view.makeToast(SignUpToastMessages.birth.messages, duration: 1, position: .top)
        }
    }
    
    func pushScene() {
        let baseViewToChange = EmailView()
        let vc = EmailViewController(mainView: baseViewToChange, signUpData: viewModel.signUpData)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() { mainView.textFieldBorderAttribute() }
}

extension BirthViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return viewModel.yearArray.count
        case 1:
            return viewModel.monthArray.count
        case 2:
            return viewModel.dayArray.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(viewModel.yearArray[row])년"
        case 1:
            return "\(viewModel.monthArray[row])월"
        case 2:
            return "\(viewModel.dayArray[row])일"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            mainView.birthYearTextField.text = "\(viewModel.yearArray[row])"
        case 1:
            mainView.birthMonthTextField.text = "\(viewModel.monthArray[row])"
        case 2:
            mainView.birthDayTextField.text = "\(viewModel.dayArray[row])"
        default:
            ""
        }
    }
}
