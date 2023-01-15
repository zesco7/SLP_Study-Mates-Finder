//
//  BaseView.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import Foundation
import UIKit
import SnapKit

protocol BaseViewDelegate: NSObject {
    
    func configure()
    
    func setConstraints()
}

class BaseView: UIView, BaseViewDelegate {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() { }
    
    func setConstraints() { }
}
