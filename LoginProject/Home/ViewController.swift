//
//  ViewController.swift
//  LoginProject
//
//  Created by Phan Hai on 31/07/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    private var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        
        let p = ["email": "phule@gmail.com", "password": "1234566"]
        RequestManager.APIData(ofType: OptionalMessageDTO<LoginModel>.self, url: APILink.login.value, parameters: p, method: .post)
            .subscribe(onNext: { (value) in
            switch value {
            case .success(let data):
                break
            case .failure(let err):
                print(err)
                break
                }
            }, onError: { (err) in
                print(err.localizedDescription)
            }).disposed(by: disposeBag)
    }

}

