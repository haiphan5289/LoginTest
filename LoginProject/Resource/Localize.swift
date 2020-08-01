//
//  Localize.swift
//  LoginProject
//
//  Created by Phan Hai on 01/08/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//
import UIKit

enum LocalizeText: String {
    case email = "Email"
    case login = "Đăng nhập"
    case password = "Mật khẩu"
    
    var text: String {
        return rawValue
    }
    
    var localizedText: String {
        return NSLocalizedString(text, comment: "")
    }
}
