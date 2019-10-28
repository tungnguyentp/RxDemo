//
//  HomeViewController.swift
//  RxDemo
//
//  Created by IMAC on 10/28/19.
//  Copyright © 2019 IMAC. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Then

class HomeViewController: UIViewController {
    @IBOutlet weak var tbvHome: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        APIManager.getListCategory().subscribe(onSuccess: { (categories) in
            print(categories.count)
        }){ (error) in
            print(error)
        }
        
    }
    
    func configView(){
        title = "Home"
        tbvHome.do {
            $0.rowHeight = 100
            $0.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        }
    }

}
