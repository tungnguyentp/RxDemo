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
        let isEnableButton: Observable<Bool>
        let isValidatePass: Observable<Bool>
    }
    
    let userName = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    
    func transform(input: Input) -> Output{
        
        let isValidatePass = password.skip(2).map { (text) -> Bool in
            return text.count > 6
        }.distinctUntilChanged()
        
        let isValidateEMail = userName.skip(2).map { (text) -> Bool in
            let isVali = self.ValidateEmailString(strEmail: text)
            return isVali
            }.distinctUntilChanged()
        
        let isEnableBTN = Observable.combineLatest(
            userName, isValidateEMail, isValidatePass,
            resultSelector: { value1,value2,value3 in
                return value1.count > 3 && value2 && value3
        })
        
        return Output.init(insValidateEmail: isValidateEMail, isEnableButton: isEnableBTN, isValidatePass: isValidatePass)
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
