//
//  XWAKAlertViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/7/24.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let btn = UIButton(type: .system)
        btn.setTitle("提示", for: .normal)
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
        btn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(btnTouched(_:)), for: .touchUpInside)
        
        _ = btn.xwak.centerX(equalTo: view.xwak.centerX)
                    .centerY(equalTo: view.xwak.centerY)
                    .width(equalTo: view.xwak.width, -30)
                    .height(50)
        
//        NSLayoutConstraint.activate([
//            btn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            btn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            btn.widthAnchor.constraint(equalToConstant: 100),
//            btn.heightAnchor.constraint(equalToConstant: 50)
//        ])
    }
    
    @objc
    func btnTouched(_ sender: UIButton) {
        XWAKAlert.show(title: "标题", msg: "内容", ok: "确定", cancel: "取消", delay: 1.5, okHandler: { () -> Void? in
            print("ok handler")
        }) { () -> Void? in
            print("cancel handler")
        }
    }

}
