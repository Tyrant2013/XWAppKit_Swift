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
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(btnTouched(_:)), for: .touchUpInside)
    }
    
    @objc
    func btnTouched(_ sender: UIButton) {
        XWAKAlert.show(title: "标题", msg: "内容", ok: "确定", cancel: "取消", delay: 1.5, okHandler: { () -> Void? in
            print("ok handler")
        }) { () -> Void? in
            print("cancel handler")
        }
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
