//
//  GenderViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import UIKit

import FirebaseAuth
import RxCocoa
import RxSwift

class GenderViewController: UIViewController {
    var mainView: GenderView
    let viewModel = GenderViewModel()
    let disposeBag = DisposeBag()
    let border = CALayer()
    let genderCode = BehaviorSubject<Int>(value: 2)
    
    init(mainView: GenderView) {
        self.mainView = mainView
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
        sendGenderEvent()
        activateAction()
    }
    
    func bind() {
        //disposebag 어떻게?
        viewModel.genderCodeEvent.asDriver(onErrorJustReturn: 2)
            .drive { genderCode in
                if genderCode == 0 {
                    self.mainView.femaleButton.whiteGreen()
                    self.mainView.maleButton.backgroundColor = .white
                    self.mainView.genderButton.green()
                } else if genderCode == 1 {
                    self.mainView.maleButton.whiteGreen()
                    self.mainView.femaleButton.backgroundColor = .white
                    self.mainView.genderButton.green()
                } else {
                    self.mainView.maleButton.backgroundColor = .white
                    self.mainView.femaleButton.backgroundColor = .white
                }
            }
    }
    
    func sendGenderEvent() {
        viewModel.maleButtonTapped(mainView: mainView)
        viewModel.femaleButtonTapped(mainView: mainView)
    }
    
    func activateAction() { mainView.genderButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside) }
    
    @objc func buttonTapped() { viewModel.buttonTapped(self) }
}
