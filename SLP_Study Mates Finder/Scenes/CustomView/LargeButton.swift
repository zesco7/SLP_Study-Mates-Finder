//
//  LargeButton.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/11.
//

import Foundation
import UIKit

class LargeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.gray6()
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 10
    }
}
