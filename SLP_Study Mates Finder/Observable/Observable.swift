//
//  Observable.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/12.
//

import Foundation

class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didSet", value)
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value)
        listener = closure
    }
}

