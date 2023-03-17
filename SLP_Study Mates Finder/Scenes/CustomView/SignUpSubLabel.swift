//
//  RegistrationProcessDetailLabel.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/17.
//

import Foundation
import UIKit

class SignUpSubLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.font = .systemFont(ofSize: 16)
        self.textColor = UIColor.init(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
        self.textAlignment = .center
        self.numberOfLines = 0
    }
}
