//
//  Protocols.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/05.
//

import UIKit
import RxCocoa
import RxSwift

protocol CommonMethods {
//    associatedtype T
//    associatedtype R
//    var phoneNumberEvent: R { get }
//    var phoneNumber: T { get }
//    func phoneNumberValidation(number: T)
    var baseView: BaseView { get }
    func buttonTapped(_ viewController: UIViewController)
}
