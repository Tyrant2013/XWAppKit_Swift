//
//  XWAKHudViewController.swift
//  XWAppKitDemo
//
//  Created by ZHXW on 2020/7/27.
//  Copyright © 2020 ZhuanagXiaowei. All rights reserved.
//

import UIKit
import XWAppKit_Swift

class XWAKHudViewController: UIViewController {

    private let hud = XWAKHud()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let noTitleBtn = makeButton(title: "无标题", action: #selector(showWithNoTitle(_:)))
        
        let hasTitleBtn = makeButton(title: "有标题", action: #selector(showWithTitle(_:)))
        
        let noTitleAndMsg = makeButton(title: "无标题和内容", action: #selector(showWithNoTitleAndMsg(_:)))
        
        let dismissBtn = makeButton(title: "隐藏", action: #selector(dismissHud(_:)))
        
        noTitleBtn.frame = CGRect(x: 100, y: 200, width: 100, height: 30)
        hasTitleBtn.frame = CGRect(x: 100, y: 240, width: 100, height: 30)
        noTitleAndMsg.frame = CGRect(x: 100, y: 280, width: 150, height: 30)
        dismissBtn.frame = CGRect(x: 210, y: 200, width: 100, height: 30)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hud.dismiss()
    }
    
    private func makeButton(title: String, action: Selector) -> UIButton {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: action, for: .touchUpInside)
        btn.setTitle(title, for: .normal)
        btn.layer.borderWidth = 1
        view.addSubview(btn)
        return btn
    }
    
    @objc
    func showWithNoTitle(_ sender: UIButton) {
        hud.show(title: nil, msg: "这个没有标题")
    }
    
    @objc
    func showWithTitle(_ sender: UIButton) {
        hud.show(title: "这里是标题", msg: "这个有标题")
    }
    
    @objc
    func showWithNoTitleAndMsg(_ sender: UIButton) {
        hud.show(title: nil, msg: nil)
    }
    
    @objc
    func dismissHud(_ sender: UIButton) {
        hud.dismiss()
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
