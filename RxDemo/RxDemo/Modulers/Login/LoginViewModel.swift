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
        let insValidateEmail:Observable<Bool>
        let isEnableButton: Driver<Bool>
    }
    
    let userName = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    
    func transform(input: Input) -> Output{
        
      
        let isEnableCount = Observable.combineLatest(
            userName, password,
            resultSelector: { value1, value2 in
                
                return value1.count > 3 && value2.count > 3
  
        }).observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: false)
        

        let isValidateEMail = userName.map { (text) -> Bool in
             let isVali = self.ValidateEmailString(strEmail: text)
            return isVali
        }.distinctUntilChanged()
        
        print(isEnableCount)
        
//        let bac = Observable.combineLatest(isEnableCount, isValidateEMail) { (v1, v2) in
//            return v1 && v2
//            }.observeOn(MainScheduler.instance)
//            .asDriver(onErrorJustReturn: false)
        
    
   
        return Output.init(insValidateEmail: isValidateEMail, isEnableButton: isEnableCount)
    }
    
    
    
    func ValidateEmailString (strEmail: String) -> Bool
    {
      //  var isBool = BehaviorRelay(value: false)
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailText = NSPredicate(format:"SELF MATCHES [c]%@",emailRegex)
     //   isBool = BehaviorRelay.init(value: emailText.evaluate(with: strEmail))
        return emailText.evaluate(with: strEmail)
    }
    
}
