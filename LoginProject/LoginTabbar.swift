//
//  LoginTabbar.swift
//  LoginProject
//
//  Created by Phan Hai on 31/07/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


enum TabbarType: Int, CaseIterable {
    case home
    case setting
    
    var text: String {
        switch self {
        case .home:
            return "Home"
        case .setting:
            return "Setting"
            
        }
    }
}


final class LoginTabbar: UITabBarController {
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        visualize()
    }
    
    private func visualize() {
        let home = ViewController()
        let search = Settings()
        viewControllers = [home, search]
        TabbarType.allCases.forEach { (type) in
            if let controller = viewControllers {
                let item = controller[type.rawValue]
                item.tabBarItem.title = type.text
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = ""
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.title = ""
    }
}
