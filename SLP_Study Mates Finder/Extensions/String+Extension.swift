//
//  String+Extension.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2023/03/13.
//

import Foundation

extension String {
  public var withHypen: String {
    var stringWithHypen: String = self
    
    stringWithHypen.insert("-", at: stringWithHypen.index(stringWithHypen.startIndex, offsetBy: 3))
    stringWithHypen.insert("-", at: stringWithHypen.index(stringWithHypen.endIndex, offsetBy: -4))
    
    return stringWithHypen
  }
}
