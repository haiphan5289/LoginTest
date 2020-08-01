//
//  LoginVM.swift
//  LoginProject
//
//  Created by Phan Hai on 01/08/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

struct LoginVM {
    private let disposeBag = DisposeBag()
    var reponseAPI: PublishSubject<(Bool, String)> = PublishSubject.init()
    var isBlockUI: PublishSubject<Bool> = PublishSubject.init()
    func login(email: String, password: String) {
        isBlockUI.onNext(true)
        let p = ["email": email, "password": password]
        RequestManager.APIData(ofType: OptionalMessageDTO<UserModel>.self, url: APILink.login.value, parameters: p, method: .post)
            .subscribe(onNext: { (value) in
                switch value {
                case .success(let data):
                    self.reponseAPI.onNext((true, data.message ?? ""))
                    self.isBlockUI.onNext(false)
                case .failure(let err):
                    self.reponseAPI.onNext((false, err.message ?? ""))
                    self.isBlockUI.onNext(false)
                }
            }, onError: { (err) in
                self.reponseAPI.onNext((false, err.localizedDescription))
                self.isBlockUI.onNext(false)
            }).disposed(by: disposeBag)
    }
}
