//
//  XWAppKitSwitchViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAppKitSwitchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let btn = XWAKSwitchButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(btn)
        btn.xwak.width(50)
            .height(50)
            .centerY(equalTo: view.xwak.centerY)
            .centerX(equalTo: view.xwak.centerX)
        
//        NSLayoutConstraint.activate([
//            btn.widthAnchor.constraint(equalToConstant: 50),
//            btn.heightAnchor.constraint(equalToConstant: 50),
//            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
