//
//  BirthCustomView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/10.
//

import UIKit
import SnapKit

class BirthCustomView: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let birthDatePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.frame = CGRect(x: 10, y: 50, width: view.frame.width, height: 200)
        view.datePickerMode = .date
        view.preferredDatePickerStyle = .wheels
        var components = DateComponents()
        components.year = 0
        let maxDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        components.year = -100
        let minDate = Calendar.autoupdatingCurrent.date(byAdding: components, to: Date())
        view.maximumDate = maxDate
        view.minimumDate = minDate
        return view
    }()
    
    lazy var birthYearTextField: UITextField = {
        let view = UITextField()
        view.inputView = birthDatePicker
        view.textColor = .black
        view.borderStyle = .none
        view.textAlignment = .center
        return view
    }()
    
    let birthYearLabel: UILabel = {
        let view = UILabel()
        view.text = "년"
        view.font = .systemFont(ofSize: 16)
        view.black()
        return view
    }()
    
    lazy var birthMonthTextField: UITextField = {
        let view = UITextField()
        view.inputView = birthDatePicker
        view.textColor = .black
        view.borderStyle = .none
        view.textAlignment = .center
        return view
    }()
    
    let birthMonthLabel: UILabel = {
        let view = UILabel()
        view.text = "월"
        view.font = .systemFont(ofSize: 16)
        view.black()
        return view
    }()
    
    lazy var birthDayTextField: UITextField = {
        let view = UITextField()
        view.inputView = birthDatePicker
        view.textColor = .black
        view.borderStyle = .none
        view.textAlignment = .center
        return view
    }()
    
    let birthDayLabel: UILabel = {
        let view = UILabel()
        view.text = "일"
        view.font = .systemFont(ofSize: 16)
        view.black()
        return view
    }()
    
    func configure() {
        [birthDatePicker, birthYearTextField, birthYearLabel, birthMonthTextField, birthMonthLabel, birthDayTextField, birthDayLabel].forEach {
            self.addSubview($0)
        }
    }
    
    func setConstraints() {
        birthDatePicker.snp.makeConstraints { make in
            make.leadingMargin.equalTo(0)
            make.width.equalTo(self)
            make.bottomMargin.equalTo(0)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
//        birthYearTextField.snp.makeConstraints { make in
//            make.width.equalTo(70)
//            make.height.equalTo(30)
//            make.leadingMargin.equalTo(20)
//            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
//        }
//
//        birthYearLabel.snp.makeConstraints { make in
//            make.width.equalTo(20)
//            make.height.equalTo(20)
//            make.leading.equalTo(birthYearTextField.snp.trailing).offset(1)
//            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
//        }
//
//        birthMonthTextField.snp.makeConstraints { make in
//            make.width.equalTo(70)
//            make.height.equalTo(30)
//            make.centerX.equalTo(self).offset(-10)
//            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
//        }
//
//        birthMonthLabel.snp.makeConstraints { make in
//            make.width.equalTo(20)
//            make.height.equalTo(20)
//            make.leading.equalTo(birthMonthTextField.snp.trailing).offset(1)
//            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
//        }
//
//        birthDayTextField.snp.makeConstraints { make in
//            make.width.equalTo(70)
//            make.height.equalTo(30)
//            make.trailing.equalTo(birthDayLabel.snp.leading).offset(1)
//            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
//        }
//
//        birthDayLabel.snp.makeConstraints { make in
//            make.width.equalTo(20)
//            make.height.equalTo(20)
//            make.trailingMargin.equalTo(-20)
//            make.bottom.equalTo(birthPassButton.snp.top).offset(-60)
//        }
    }
}


