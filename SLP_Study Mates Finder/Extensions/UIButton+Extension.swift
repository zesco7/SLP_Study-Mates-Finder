//
//  UIButton+Extension.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/11.
//

import Foundation
import UIKit

extension UIButton {
//    func buttonFontAttribute() {
//        self.titleLabel?.textColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
//        self.titleLabel?.textAlignment = .center
//        self.titleLabel?.font = .systemFont(ofSize: 13)
//    }
    
    func green() {
        self.backgroundColor = UIColor.init(red: 73/255, green: 220/255, blue: 146/255, alpha: 1)
    }
    
    func whiteGreen() {
        self.backgroundColor = UIColor.init(red: 205/255, green: 244/255, blue: 225/255, alpha: 1)
    }
    
    func yellowGreen() {
        self.backgroundColor = UIColor.init(red: 178/255, green: 235/255, blue: 97/255, alpha: 1)
    }
    
    func gray7() {
        self.backgroundColor = UIColor.init(red: 136/255, green: 136/255, blue: 136/255, alpha: 1)
    }
    
    func gray6() {
        self.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
    }
    
    func gray5() {
        self.backgroundColor = UIColor.init(red: 189/255, green: 189/255, blue: 189/255, alpha: 1)
    }
    
    func gray4() {
        self.backgroundColor = UIColor.init(red: 209/255, green: 209/255, blue: 209/255, alpha: 1)
    }
    
    func gray3() {
        self.backgroundColor = UIColor.init(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
    }
    
    func gray2() {
        self.backgroundColor = UIColor.init(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
    }
    
    func gray() {
        self.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    }
}
