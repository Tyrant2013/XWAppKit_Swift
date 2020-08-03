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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let noTitleBtn = makeButton(title: "无标题", action: #selector(showWithNoTitle(_:)))
        
        let hasTitleBtn = makeButton(title: "有标题", action: #selector(showWithTitle(_:)))
        
        let noTitleAndMsg = makeButton(title: "无标题和内容", action: #selector(showWithNoTitleAndMsg(_:)))
        
        let autoDismiss = makeButton(title: "自动隐藏", action: #selector(autoDismiss(_:)))
        
        let dismissBtn = makeButton(title: "隐藏", action: #selector(dismissHud(_:)))
        
        noTitleBtn.frame = CGRect(x: 100, y: 200, width: 100, height: 40)
        hasTitleBtn.frame = CGRect(x: 100, y: 260, width: 100, height: 40)
        noTitleAndMsg.frame = CGRect(x: 100, y: 320, width: 150, height: 40)
        autoDismiss.frame = CGRect(x: 100, y: 380, width: 120, height: 40)
        dismissBtn.frame = CGRect(x: 210, y: 260, width: 100, height: 40)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        XWAKHud.dismiss()
    }
    
    private func makeButton(title: String, action: Selector) -> UIButton {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: action, for: .touchUpInside)
        btn.setTitle(title, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.layer.cornerRadius = 10
        view.addSubview(btn)
        return btn
    }
    
    @objc
    func showWithNoTitle(_ sender: UIButton) {
        XWAKHud.show(msg: "这个没有标题", ignoreInteraction: false)
    }
    
    @objc
    func showWithTitle(_ sender: UIButton) {
        XWAKHud.show(title: "这里是标题", msg: "这个有标题", ignoreInteraction: false)
    }
    
    @objc
    func showWithNoTitleAndMsg(_ sender: UIButton) {
        XWAKHud.wait()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XWAKHud.dismiss()
        }
    }
    
    @objc
    func autoDismiss(_ sender: UIButton) {
        XWAKHud.show(in: view, title: "", msg: "会自动隐藏的", delay: 1.5)
    }
    
    @objc
    func dismissHud(_ sender: UIButton) {
        XWAKHud.dismiss()
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
