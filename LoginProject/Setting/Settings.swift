//
//  Settings.swift
//  LoginProject
//
//  Created by Phan Hai on 31/07/2020.
//  Copyright © 2020 Phan Hai. All rights reserved.
//
import UIKit

final class Settings: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        visualize()
    }
}
extension Settings {
    private func visualize() {
        self.view.backgroundColor = .green
        
        let lbHome: UILabel = UILabel(frame: .zero)
        lbHome.text = LocalizeText.setting.localizedText
        lbHome.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        lbHome.textColor = .black
        self.view.addSubview(lbHome)
        lbHome.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

