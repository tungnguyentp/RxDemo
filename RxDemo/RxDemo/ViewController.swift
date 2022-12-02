//
//  ViewController.swift
//  RxDemo
//
//  Created by IMAC on 10/22/19.
//  Copyright © 2019 IMAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnLogin: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblTitle.text = R.string.localizable.loginLogin()

       //
    }


}
