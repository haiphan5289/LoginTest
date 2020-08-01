//
//  Localize.swift
//  LoginProject
//
//  Created by Phan Hai on 01/08/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//
import UIKit

enum LocalizeText: String {
    case close = "Đóng"
    case email = "Email"
    case home = "Trang chủ"
    case login = "Đăng nhập"
    case notify = "Thông báo"
    case password = "Mật khẩu"
    case setting = "Cài đặt"
    
    var text: String {
        return rawValue
    }
    
    var localizedText: String {
        return NSLocalizedString(text, comment: "")
    }
}
