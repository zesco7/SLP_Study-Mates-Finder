//
//  BaseViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        configure()
    }
    
    func attribute() {
        view.backgroundColor = .white
    }
    
    func configure() { }
}
