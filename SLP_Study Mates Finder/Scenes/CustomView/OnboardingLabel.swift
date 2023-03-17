//
//  OnboardingLabel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/11.
//

import Foundation
import UIKit

class OnboardingLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.font = .systemFont(ofSize: 24)
        self.textColor = .black
        self.textAlignment = .center
        self.numberOfLines = 0
    }
}
