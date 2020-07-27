//
//  XWAKToastViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/7/27.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKToastViewController: UIViewController {

    private let toast = XWAKToast()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        let btn = UIButton(type: .system)
        btn.layer.borderWidth = 1
        btn.setTitle("显示", for: .normal)
        btn.addTarget(self, action: #selector(show(_:)), for: .touchUpInside)
        view.addSubview(btn)
        btn.frame = CGRect(x: 100, y: 200, width: 100, height: 50)
        
        let dism = UIButton(type: .system)
        dism.layer.borderWidth = 1
        dism.setTitle("隐藏", for: .normal)
        dism.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
        view.addSubview(dism)
        dism.frame = CGRect(x: 210, y: 200, width: 100, height: 50)
    }
    

    @objc
    func show(_ sender: UIButton) {
        toast
            .message("测试一下")
            .show(view)
    }
    
    @objc
    func dismiss(_ sender: UIButton) {
        toast.dismiss()
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
