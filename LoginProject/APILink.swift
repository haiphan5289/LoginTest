//
//  APILink.swift
//  LoginProject
//
//  Created by Phan Hai on 01/08/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//

enum APILink: String {
    case login
    
    var value: String {
        switch self {
        case .login:
            return "user/login"
        }
    }
}
