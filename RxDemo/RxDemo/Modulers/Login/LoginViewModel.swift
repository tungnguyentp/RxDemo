//
//  LoginViewModel.swift
//  RxDemo
//
//  Created by IMAC on 10/23/19.
//  Copyright © 2019 IMAC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class LoginViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let btnLogin: Driver<Void>
    }
    
    struct Output {
        let isEnableButton: Driver<Bool>
    }
    
    let userName = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    
    func transform(input: Input) -> Output{
        
      
        let isEnable = Observable.combineLatest(
            userName, password,
            resultSelector: { value1, value2 in
                
                return value1.count > 3 && value2.count > 3
  
        }).observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: false)
   
        return Output.init(isEnableButton: isEnable)
    }
    
}
