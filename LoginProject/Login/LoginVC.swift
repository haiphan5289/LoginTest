//
//  LoginVC.swift
//  LoginProject
//
//  Created by Phan Hai on 01/08/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginVC: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    private let loginVM = LoginVM()
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        visualize()
        setupRX()
    }

}
extension LoginVC {
    private func visualize() {
        tfEmail.placeholder = LocalizeText.email.localizedText
        tfPassword.placeholder = LocalizeText.password.localizedText
        
        btLogin.clipsToBounds = true
        btLogin.layer.cornerRadius = 5
        btLogin.setTitle("  \(LocalizeText.login.localizedText)  ", for: .normal)
    }
    private func setupRX() {
        let email = self.tfEmail.rx.text.orEmpty.map { (value) -> Bool in
            return self.isValidEmail(email: value)
        }
        let password = self.tfPassword.rx.text.orEmpty.map { (value) -> Bool in
            return value.count > 0
        }
        
        Observable.combineLatest(email, password).map { (isEmail, isPassword) -> Bool in
            return isEmail && isPassword
        }.bind { [weak self] (isValid) in
            guard let wSelf = self else { return }
            wSelf.btLogin.setTitleColor((isValid) ? UIColor.white: UIColor.gray, for: .normal)
            wSelf.btLogin.isEnabled = isValid
        }.disposed(by: disposeBag)
        
        btLogin.rx.tap.bind { [weak self] in
            guard let wSelf = self, let email = wSelf.tfEmail.text, let password = wSelf.tfPassword.text else {
                return
            }
            wSelf.loginVM.login(email: email, password: password)
        }.disposed(by: disposeBag)
        
        loginVM.reponseAPI.bind { [weak self] (isSuccess, msg) in
            guard let wSelf = self else { return }
            
            guard isSuccess else {
                wSelf.showAlertError(msg: msg)
                return
            }
            wSelf.dismiss(animated: true, completion: nil)
            wSelf.inputUserDefault(ofType: msg, key: UserDefaulStandard.userInfo.rawValue)
        }.disposed(by: disposeBag)
        
        loginVM.isBlockUI.asObserver().bind { [weak self] (isBlock) in
            guard let wSelf = self else { return }
            wSelf.btLogin.isEnabled = !isBlock
        }.disposed(by: disposeBag)
    }
    private func showAlertError(msg: String) {
        let alert: UIAlertController = UIAlertController(title: "Thông báo", message: msg, preferredStyle: .alert)
        let btCancel: UIAlertAction = UIAlertAction(title: "Đóng", style: .cancel, handler: nil)
        alert.addAction(btCancel)
        self.present(alert, animated: true, completion: nil)
    }
}
