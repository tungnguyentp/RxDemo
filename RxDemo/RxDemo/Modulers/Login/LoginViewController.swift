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

    @IBOutlet weak var lblErrorPass: UILabel!
    @IBOutlet weak var lblErrorEmail: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var tfUser: UITextField!
    
    let disposeBag = DisposeBag()
    var viewModel = LoginViewModel()
  //  let api = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = APIManager.login().subscribe(onSuccess: { (baseClass) in
            print(baseClass.displayName as Any)
        }) { (error) in
            print(error)
        }

     //   print(user)

        // Do any additional setup after loading the view.
        setUpBindings()
    }
    
    private func setUpBindings() {
    //     guard let viewModel = viewModel else { return }
        self.lblErrorEmail.text = ""
        self.lblErrorPass.text = ""
        self.btnLogin.isEnabled = false
        
        self.tfUser.rx.text.orEmpty.skip(2).asObservable()
        .bind(to: viewModel.userName).disposed(by: disposeBag)
        
        self.tfPass.rx.text.orEmpty
            .bind(to: viewModel.password).disposed(by: disposeBag)
        
        btnLogin.rx.tap.subscribe { (_) in
            let homeVC = HomeViewController.init(nibName: "HomeViewController", bundle: nil)
            self.navigationController?.pushViewController(homeVC, animated: true)
        }.disposed(by: disposeBag)
       
        let input = LoginViewModel.Input.init(btnLogin: btnLogin.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        
        output.isEnableButton.subscribe { isVali in
            self.btnLogin.isEnabled = isVali.element!
        }.disposed(by: disposeBag)

        
        output.isValidatePass.subscribe { isVali in
            self.lblErrorPass.text = isVali.element! ? "" : "Pass phải lớn hơn 6 kí tự"
        }.disposed(by: disposeBag)
        
        output.insValidateEmail.subscribe { isVali in
             self.lblErrorEmail.text = isVali.element! ? "" : "Mail sai định dạng"
        }.disposed(by: disposeBag)
    }
}
