//
//  LoginViewController.swift
//  RxDemo
//
//  Created by IMAC on 10/23/19.
//  Copyright © 2019 IMAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfUser: UITextField!
    
    let disposeBag = DisposeBag()
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpBindings()
    }
    
    private func setUpBindings() {
        guard let viewModel = self.viewModel else { return }
        
        self.tfUser.rx.text.orEmpty.asObservable()
        .bind(to: viewModel.userName).disposed(by: disposeBag)
        
        self.tfPass.rx.text.orEmpty
            .bind(to: viewModel.password).disposed(by: disposeBag)
       
        let input = LoginViewModel.Input.init(btnLogin: btnLogin.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        output.isEnableButton.drive(btnLogin.rx.isEnabled).disposed(by: disposeBag)
    }
}
