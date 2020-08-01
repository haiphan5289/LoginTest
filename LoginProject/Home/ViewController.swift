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
    private var homeVM: HomeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        
        if let appDomain = Bundle.main.bundleIdentifier {
                   UserDefaults.standard.removePersistentDomain(forName: appDomain)
               }
        
        let button: UIButton = UIButton(frame: .zero)
        button.setTitle("dđ", for: .normal)
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        button.rx.tap.bind { _ in
            self.isLogin()
        }.disposed(by: disposeBag)
        

        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification).bind { _ in
            self.isLogin()
        }.disposed(by: disposeBag)
    }
    private func isLogin() {
        let user = self.readUserDefault(offtype: String.self, key: UserDefaulStandard.userInfo.rawValue)
        if (user == nil) {
            let vc = LoginVC(nibName: "LoginVC", bundle: nil)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}

