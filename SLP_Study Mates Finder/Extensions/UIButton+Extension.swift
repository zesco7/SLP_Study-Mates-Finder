//
//  UIButton+Extension.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/11.
//

import Foundation
import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
            UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
            guard let context = UIGraphicsGetCurrentContext() else { return }
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
            
            let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
             
            self.setBackgroundImage(backgroundImage, for: state)
        }
    
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
